//
//  APPCompoent+Root.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation

extension APPComponent {
    
    var permissionComponent : PermissionComponent {
        shared {
            PermissionComponent(parent: self)
        }
        
      }
    
}
