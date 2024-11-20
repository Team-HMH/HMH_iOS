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
    ///    - packages:SPM의 package
    ///    - internalDependencies: 내부 의존성
    ///    - externalDependencies: 외부 의존성
    ///    - interfaceDependencies: 인터페이스 의존성
    ///    - sources: 소스 파일
    ///    - hasResourcces: 리소스 파일 포함 여부
    static func makeModule(
        name: String,
        targets: Set<FeatureTarget> = Set([.staticFramework, .unitTest, .demo]),
        packages: [Package] = [],
        internalDependencies: [TargetDependency] = [],
        externalDependencies: [TargetDependency] = [],
        interfaceDependencies: [TargetDependency] = [],
        sources: SourceFilesList? = nil,
        hasResources: Bool = false
    ) -> Project {
        let configurationName: ConfigurationName = "Development"
        
        var projectTargets: [Target] = []
        var schemes: [Scheme] = []
        
        targets.forEach { targetType in
            var target: Target
            switch targetType {
            case .app:
                target = TargetHandler.makeAppTarget(
                    name: name,
                    dependencies: internalDependencies + externalDependencies
                )
            case .interface:
                target = TargetHandler.makeInterfaceTarget(
                    name: name,
                    interfaceDependencies: interfaceDependencies
                )
            case .staticFramework:
                let deps: [TargetDependency] = targets.contains(.interface) 
                ? [.target(name: "\(name)Interface")]
                : []
                target = TargetHandler.makeStaticFrameworkTarget(
                    name: name,
                    hasResources: hasResources,
                    dependencies: deps + internalDependencies + externalDependencies
                )
            case .dynamicFramework:
                let deps: [TargetDependency] = targets.contains(.interface) 
                ? [.target(name: "\(name)Interface")]
                : []
                target = TargetHandler.makeDynamicFrameworkTarget(
                    name: name,
                    hasResources: hasResources,
                    dependencies: deps + internalDependencies + externalDependencies
                )
            case .unitTest:
                target = TargetHandler.makeUnitTestTarget(name: name)
            case .demo:
                target = TargetHandler.makeDemoTarget(name: name)
            }
            
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
        
        
        var scheme = targets.contains(.app) ? Scheme.appSchemes : schemes
        
        if name.contains("Demo") {
            let testAppScheme = Scheme.makeScheme(configs: "QA", name: name)
            scheme.append(testAppScheme)
        }
        
        return Project(
            name: name,
            organizationName: env.workspaceName,
            packages: packages,
            settings: .settings(configurations: XCConfig.configurations),
            targets: projectTargets,
            schemes: schemes
        )
    }
}
