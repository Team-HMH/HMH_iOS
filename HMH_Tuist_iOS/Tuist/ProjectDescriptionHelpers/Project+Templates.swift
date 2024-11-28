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
        let dependencies: [TargetDependency] = internalDependencies + externalDependencies + interfaceDependencies
        
        let projectTargets: [Target] = TargetHandler.makeProjectTargets(
            name: name,
            hasResources: hasResources,
            with: dependencies,
            targets: targets
        )
        let projcetScheme: [Scheme] = SchemeProvider.makeProjectScheme(targets: targets, name: name)
        
        return Project(
            name: name,
            organizationName: env.workspaceName,
            packages: packages,
            settings: .settings(configurations: XCConfig.configurations),
            targets: projectTargets,
            schemes: projcetScheme
        )
    }
}
