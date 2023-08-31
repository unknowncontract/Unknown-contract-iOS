//
//  APPComponent+Result.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import Foundation

extension APPComponent {
    
    var resultComponent : ResultComponent {
        shared {
            ResultComponent(parent: self)
        }
        
      }
    
}
