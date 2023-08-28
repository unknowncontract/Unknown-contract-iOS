

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

private class RootDependency82f254bdb0601b002a2cProvider: RootDependency {


    init() {

    }
}
/// ^->AppComponent2->RootComponent
private func factory827760ebdc24ef5a7085e3b0c44298fc1c149afb(_ component: NeedleFoundation.Scope) -> AnyObject {
    return RootDependency82f254bdb0601b002a2cProvider()
}

#else
extension AppComponent2: Registration {
    public func registerItems() {


    }
}
extension RootComponent: Registration {
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
    registerProviderFactory("^->AppComponent2", factoryEmptyDependencyProvider)
    registerProviderFactory("^->AppComponent2->RootComponent", factory827760ebdc24ef5a7085e3b0c44298fc1c149afb)
}
#endif

public func registerProviderFactories() {
#if !NEEDLE_DYNAMIC
    register1()
#endif
}
