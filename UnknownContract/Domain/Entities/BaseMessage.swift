//
//  BaseMessage.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation


public struct BaseMessage{
    
    let type:Document
    
    let score:Int
    
    
    var warings:[Warning]
}


public struct Warning{
    var isOpen:Bool = false
    let name:String
    let description:String
}
