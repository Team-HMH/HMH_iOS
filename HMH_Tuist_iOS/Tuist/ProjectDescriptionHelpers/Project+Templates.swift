import ProjectDescription
import ConfigPlugin
import EnvPlugin


public extension Project {
    /// Sumarry: 모듈을 만드는 함수
    ///
    /// Discussion/Overview
    ///
    /// - Parameters:
    ///    - name: 프로젝트 이름 (모듈 이름)
    ///    - targets: 빌드할 타겟의 대상
    ///    - organizationName: organization 이름
    ///    - packages:SPM의 package
    ///    - internalDependencies: 내부 의존성
    ///    - externalDependencies: 외부 의존성
    ///    - interfaceDependencies: 인터페이스 의존성
    ///    - sources: 소스 파일
    ///    - hasResourcces: 리소스 파일 포함 여부
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
        organizationName: String = "HMH-iOS",
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        sources: SourceFilesList? = nil,
        hasResources: Bool = false
    ) -> Project {
        let configurationName: ConfigurationName = "Development"
        let hasDynamicFramework = targets.contains(.dynamicFramework)
        let baseSetting: SettingsDictionary = [:]
        
        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        // MARK: - APP
        
        if targets.contains(.app) {
            let bundleSuffix = name.contains("Demo") ? "test" : "release"
            var infoPlist = name.contains("Demo") ? Project.demoInfoPlist : Project.appInfoPlist
            
            switch name {
            case "DeviceActivityMonitor":
                infoPlist = Project.deviceActivityMonitorInfoPlist
            case "HMHDeviceActivityReport":
                infoPlist = Project.hmhDeviceActivityReportInfoPlist
            case "ShieldActionExtension":
                infoPlist = Project.shieldActionExtensionInfoPlist
            case "ShieldConfigureExtension":
                infoPlist = Project.shieldConfigureExtensionInfoPlist
            default:
                break
            }
            
            let setting = baseSetting
            
            let target = Target(
                name: name,
                platform: env.platform,
                product: .app,
                bundleId: "\(env.bundlePrefix).\(bundleSuffix)",
                deploymentTarget: env.deploymentTarget,
                //infoPlist에 .extendingDefault로 Info.plsit에 추가 내용을 넣어준 이유는 tuist에서 .default 만들어주는 Info.plist는 앱을 실행할 때 화면이 어딘가 나사가 빠진상태로 실행되기 때문입니다.
                infoPlist: .extendingDefault(with: infoPlist),
                sources: .sources,
                // 터미널 명령어랑 비슷한듯? 일단 바쁘니까 나중에 정리해보도록 하자ㅏ https://www.daleseo.com/glob-patterns/#google_vignette
                resources: [.glob(pattern: "Resources/**", excluding: [])],
                //entitlement: 주로 iOS 애플리케이션에서 특정 기능이나 권한을 활성화하기 위해 사용하는 설정 파일
                entitlements: "\(name).entitlements",
                dependencies: [
                    internalDependencies,
                    externalDependencies
                ].flatMap { $0 },
                settings: .settings(base: setting, configurations: XCConfig.project)
            )
            projectTargets.append(target)
        }
        
        //MARK: - Feature Interface
        
        if targets.contains(.interface) {
            let setting = baseSetting
            let target = Target(
                name: "\(name)Interface",
                platform: env.platform,
                product: .framework,
                bundleId: "\(env.bundlePrefix).\(name)Interface",
                deploymentTarget: env.deploymentTarget,
                infoPlist: .default,
                sources: .interface,
                dependencies: interfaceDependencies,
                settings: .settings(base: setting,configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        // MARK: - Framework
        
        if targets.contains(where: { $0.hasFramework }) {
            let deps: [TargetDependency] = targets.contains(.interface)
            ? [.target(name: "\(name)Interface")]
            : []
            let settings = baseSetting
            
            let target = Target(
                name: name,
                platform: env.platform,
                product: hasDynamicFramework ? .framework : .staticFramework,
                bundleId: "\(env.bundlePrefix).\(name)",
                deploymentTarget: env.deploymentTarget,
                infoPlist: .default,
                sources: .sources,
                resources: hasResources ? [.glob(pattern: "Resources/**", excluding: [])] : [],
                dependencies: deps + internalDependencies + externalDependencies,
                settings: .settings(base: settings, configurations: XCConfig.framework)
            )
            
            projectTargets.append(target)
        }
        
        //MARK: - Feature DemoApp
        
        if targets.contains(.demo) {
            let deps: [TargetDependency] = [.target(name:name)]
            let setting = baseSetting
            
            let target = Target(
                name: "\(name)Demo",
                platform: env.platform,
                product: .app,
                bundleId: "\(env.bundlePrefix).\(name)Demo",
                deploymentTarget: env.deploymentTarget,
                infoPlist: .extendingDefault(with: Project.demoInfoPlist),
                sources: .demoSources,
                resources: [.glob(pattern: "Demo/Resources/**", excluding: ["Demo/Resources/dummy.txt"])],
                dependencies: deps,
                settings: .settings(base: setting, configurations: XCConfig.demo)
            )
            projectTargets.append(target)
        }
        
        //MARK: - Unit Tests
        
        if targets.contains(.unitTest) {
            let deps: [TargetDependency] = [.target(name: name)]
            
            let target = Target(
                name: "\(name)Tests",
                platform: env.platform,
                product: .unitTests,
                bundleId: "\(env.bundlePrefix).\(name)Tests",
                deploymentTarget: env.deploymentTarget,
                infoPlist: .default,
                sources: .unitTests,
                resources: [.glob(pattern: "Tests/Resources/**", excluding: [])],
                dependencies: deps,
                settings: .settings(base: SettingsDictionary().setCodeSignManual(), configurations: XCConfig.tests)
            )
            
            projectTargets.append(target)
        }
        
        let additionalSchemes = targets.contains(.demo) ?
        [
            Scheme.makeScheme(configs: configurationName, name: name),
            Scheme.makeDemoScheme(configs: configurationName, name: name)
        ]
        : [
            Scheme.makeScheme(configs: configurationName, name: name)
        ]
        
        schemes += additionalSchemes
        
        
        var scheme = targets.contains(.app) ? appSchemes : schemes
        
        if name.contains("Demo") {
            let testAppScheme = Scheme.makeScheme(configs: "QA", name: name)
            scheme.append(testAppScheme)
        }
        
        return Project(
            name: name,
            organizationName: env.workspaceName,
            packages: packages,
            settings: .settings(configurations: XCConfig.project),
            targets: projectTargets,
            schemes: schemes
        )
    }
}

extension Project {
    static let appSchemes: [Scheme] = [
        // PROD API, debug scheme : 실제 프로덕트 BaseURL을 사용하는 debug scheme
        .init(
            name: "\(env.workspaceName)-DEV",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            testAction: .targets(
                ["\(env.workspaceName)Tests", "\(env.workspaceName)UITests"],
                configuration: "Development",
                options: .options(coverage: true, codeCoverageTargets: ["\(env.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Development"),
            archiveAction: .archiveAction(configuration: "Development"),
            profileAction: .profileAction(configuration: "Development"),
            analyzeAction: .analyzeAction(configuration: "Development")
        ),
        // Test API, debug scheme : 테스트 BaseURL을 사용하는 debug scheme
        .init(
            name: "\(env.workspaceName)-Test",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            testAction: .targets(
                ["\(env.workspaceName)Tests", "\(env.workspaceName)UITests"],
                configuration: "Test",
                options: .options(coverage: true, codeCoverageTargets: ["\(env.workspaceName)"])
            ),
            runAction: .runAction(configuration: "Test"),
            archiveAction: .archiveAction(configuration: "Test"),
            profileAction: .profileAction(configuration: "Test"),
            analyzeAction: .analyzeAction(configuration: "Test")
        ),
        // Test API, release scheme : 테스트 BaseURL을 사용하는 release scheme
        .init(
            name: "\(env.workspaceName)-QA",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            runAction: .runAction(configuration: "QA"),
            archiveAction: .archiveAction(configuration: "QA"),
            profileAction: .profileAction(configuration: "QA"),
            analyzeAction: .analyzeAction(configuration: "QA")
        ),
        // PROD API, release scheme : 실제 프로덕트 BaseURL을 사용하는 release scheme
        .init(
            name: "\(env.workspaceName)-PROD",
            shared: true,
            buildAction: .buildAction(targets: ["\(env.workspaceName)"]),
            runAction: .runAction(configuration: "PROD"),
            archiveAction: .archiveAction(configuration: "PROD"),
            profileAction: .profileAction(configuration: "PROD"),
            analyzeAction: .analyzeAction(configuration: "PROD")
        ),
        // Test API, debug scheme, Demo App Target
        .makeDemoAppTestScheme()
    ]
}
