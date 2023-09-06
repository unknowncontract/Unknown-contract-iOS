

import Foundation
import NeedleFoundation
import UIKit

// swiftlint:disable unused_declaration
private let needleDependenciesHash : String? = nil

// MARK: - Traversal Helpers

private func parent1(_ component: NeedleFoundation.Scope) -> NeedleFoundation.Scope {
    return component.parent
}

// MARK: - Providers

#if !NEEDLE_DYNAMIC

private class HomeDependency6a4768fde0821c25ee2fProvider: HomeDependency {
    var confirmComponent: ConfirmComponent {
        return aPPComponent.confirmComponent
    }
    var resultComponent: ResultComponent {
        return aPPComponent.resultComponent
    }
    private let aPPComponent: APPComponent
    init(aPPComponent: APPComponent) {
        self.aPPComponent = aPPComponent
    }
}
/// ^->APPComponent->HomeComponent
private func factorya2f9f0db50be357ca85b6684ac6e6465fdd85074(_ component: NeedleFoundation.Scope) -> AnyObject {
    return HomeDependency6a4768fde0821c25ee2fProvider(aPPComponent: parent1(component) as! APPComponent)
}
private class ResultDependenvy4793e3474137db83a995Provider: ResultDependenvy {


    init() {

    }
}
/// ^->APPComponent->ResultComponent
private func factory9658e9585f10fd5f8c64e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ResultDependenvy4793e3474137db83a995Provider()
}
private class CustomCameraDependencyb005a80e3a9dddafe7cfProvider: CustomCameraDependency {


    init() {

    }
}
/// ^->APPComponent->CustomCameraComponent
private func factorye700d9ab4cf1759d7c60e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return CustomCameraDependencyb005a80e3a9dddafe7cfProvider()
}
private class ConfirmDependency59f22d4c63227594ea1dProvider: ConfirmDependency {
    var customCameraComponent: CustomCameraComponent {
        return aPPComponent.customCameraComponent
    }
    private let aPPComponent: APPComponent
    init(aPPComponent: APPComponent) {
        self.aPPComponent = aPPComponent
    }
}
/// ^->APPComponent->ConfirmComponent
private func factory2098926d2a8f9bf54d536684ac6e6465fdd85074(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ConfirmDependency59f22d4c63227594ea1dProvider(aPPComponent: parent1(component) as! APPComponent)
}
private class PermissionDependency7a254bf5a3212ac9114cProvider: PermissionDependency {


    init() {

    }
}
/// ^->APPComponent->PermissionComponent
private func factory746bb6c0e6f49b95a2e0e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return PermissionDependency7a254bf5a3212ac9114cProvider()
}

#else
extension AppComponent: Registration {
    public func registerItems() {

    }
}
extension APPComponent: Registration {
    public func registerItems() {


    }
}
extension HomeComponent: Registration {
    public func registerItems() {
        keyPathToName[\HomeDependency.confirmComponent] = "confirmComponent-ConfirmComponent"
        keyPathToName[\HomeDependency.resultComponent] = "resultComponent-ResultComponent"
    }
}
extension ResultComponent: Registration {
    public func registerItems() {

    }
}
extension CustomCameraComponent: Registration {
    public func registerItems() {

    }
}
extension ConfirmComponent: Registration {
    public func registerItems() {
        keyPathToName[\ConfirmDependency.customCameraComponent] = "customCameraComponent-CustomCameraComponent"
    }
}
extension PermissionComponent: Registration {
    public func registerItems() {

    }
}


#endif

private func factoryEmptyDependencyProvider(_ component: NeedleFoundation.Scope) -> AnyObject {
    return EmptyDependencyProvider(component: component)
}

// MARK: - Registration
private func registerProviderFactory(_ componentPath: String, _ factory: @escaping (NeedleFoundation.Scope) -> AnyObject) {
    __DependencyProviderRegistry.instance.registerDependencyProviderFactory(for: componentPath, factory)
}

#if !NEEDLE_DYNAMIC

@inline(never) private func register1() {
    registerProviderFactory("^->AppComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->APPComponent", factoryEmptyDependencyProvider)
    registerProviderFactory("^->APPComponent->HomeComponent", factorya2f9f0db50be357ca85b6684ac6e6465fdd85074)
    registerProviderFactory("^->APPComponent->ResultComponent", factory9658e9585f10fd5f8c64e3b0c44298fc1c149afb)
    registerProviderFactory("^->APPComponent->ResultComponent", factory9658e9585f10fd5f8c64e3b0c44298fc1c149afb)
    registerProviderFactory("^->APPComponent->CustomCameraComponent", factorye700d9ab4cf1759d7c60e3b0c44298fc1c149afb)
    registerProviderFactory("^->APPComponent->ConfirmComponent", factory2098926d2a8f9bf54d536684ac6e6465fdd85074)
    registerProviderFactory("^->APPComponent->PermissionComponent", factory746bb6c0e6f49b95a2e0e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
