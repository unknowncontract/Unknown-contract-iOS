//
//  APPComponent+Confirm.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//



import Foundation

extension APPComponent {
    
    var confirmComponent : ConfirmComponent {
        shared {
            ConfirmComponent(parent: self)
        }
        
      }
    
}
