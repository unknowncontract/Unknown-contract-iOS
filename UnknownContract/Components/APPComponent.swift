//
//  AppComponent.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import Foundation
import NeedleFoundation

public final class APPComponent: BootstrapComponent {
    
    var rootComponent: ConfirmComponent {
           shared {
               ConfirmComponent(parent: self)
           }
    }
    
    
    public func makeRootView() -> ConfirmViewController {
        rootComponent.makeView()
      }
    
}
