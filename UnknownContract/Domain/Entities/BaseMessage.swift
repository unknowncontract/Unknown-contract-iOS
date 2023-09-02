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
    
    
    let warings:[Warning]
}


public struct Warning{
    let name:String
    let description:String
}
