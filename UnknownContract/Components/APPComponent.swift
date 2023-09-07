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
    
    var rootComponent: ResultComponent {
           shared {
               ResultComponent(parent: self)
           }
    }
    
  
    
    public func makeRootView() -> ResultViewController  {
        rootComponent.makeView(model: BaseMessage(type: .owner, score: 35, warings: [Warning(name: "HEllo", description: "EEEEE"),Warning(name: "HEllo", description: "EEEEE"),Warning(name: "HEllo", description: "EEEEE")]))
      }
    
}
