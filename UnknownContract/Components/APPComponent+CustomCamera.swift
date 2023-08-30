//
//  APPComponent+CustomCamera.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation


extension APPComponent {
    
    var customCameraComponent : CustomCameraComponent {
        shared {
            CustomCameraComponent(parent: self)
        }
        
      }
}
