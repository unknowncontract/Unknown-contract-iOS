//
//  PermissionComponent.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import NeedleFoundation

public protocol PermissionDependency: Dependency {
}

public final class PermissionComponent: Component<PermissionDependency> {
    public func makeView() -> PermissionViewController {
        return PermissionViewController()
        
    }
}
