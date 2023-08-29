

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

private class ConfirmDependency59f22d4c63227594ea1dProvider: ConfirmDependency {


    init() {

    }
}
/// ^->APPComponent->ConfirmComponent
private func factory2098926d2a8f9bf54d53e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return ConfirmDependency59f22d4c63227594ea1dProvider()
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
extension ConfirmComponent: Registration {
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
    registerProviderFactory("^->APPComponent->ConfirmComponent", factory2098926d2a8f9bf54d53e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
