//
//  ConfirmComponent.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import NeedleFoundation

public protocol ConfirmDependency: Dependency {
    
}

public final class ConfirmComponent: Component<ConfirmDependency> {
    public func makeView() -> ConfirmViewController {
        return ConfirmViewController()
        
    }
}
