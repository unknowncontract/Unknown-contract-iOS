//
//  BaseMessageDTO.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation

public struct BaseMessageDTO: Codable {
    
    let type: String
    let score: Int
    let warnings: [WarningDTO]
}


public struct WarningDTO:Codable {
    let name, description: String
}

extension BaseMessageDTO {
    
    func toDomain() -> BaseMessage {
        
        
        switch self.type {
            
            case "contract":
                return BaseMessage(type: .contract, score: self.score, warings: self.warnings.map{$0.toDomain()})
            
            case "owner":
                return BaseMessage(type: .owner, score: self.score, warings: self.warnings.map{$0.toDomain()})
                
            case "building":
            
                return BaseMessage(type: .building, score: self.score, warings: self.warnings.map{$0.toDomain()})
                
            default:
            
                return BaseMessage(type: .building, score: self.score, warings: self.warnings.map{$0.toDomain()})
            
        }
        
        
       
    }
    
}

extension WarningDTO {
    
    func toDomain() -> Warning {
        return Warning(name: self.name, description: self.description)
    }
}
