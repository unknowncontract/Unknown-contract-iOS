//
//  ConfirmComponent.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import NeedleFoundation

public protocol HomeDependency: Dependency {
   
    var confirmComponent: ConfirmComponent {get}
}

public final class HomeComponent: Component<HomeDependency> {
    

    public func makeView() -> HomeViewController {
        return HomeViewController(confirmComponent: dependency.confirmComponent)
        
    }
}
