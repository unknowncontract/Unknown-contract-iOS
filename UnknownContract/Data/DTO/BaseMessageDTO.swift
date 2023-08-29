//
//  BaseMessageDTO.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation

struct BaseMessageDTO: Codable {
    
    let message:String
}

extension BaseMessageDTO {
    
    func toDomain() -> BaseMessage {
        return BaseMessage(message: self.message)
    }
    
}
