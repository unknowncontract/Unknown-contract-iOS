//
//  BaseMessageDTO.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation

public struct BaseMessageDTO: Codable {
    
    let type:String
    let score:Int
    
    let warnings:[WarningDTO]
}


public struct WarningDTO:Codable {
    let name:String
    let description:String
}

extension BaseMessageDTO {
    
    func toDomain() -> BaseMessage {
        
        
        switch self.type {
            
            case "contractDoc":
                return BaseMessage(type: .contractDoc, score: self.score, warings: self.warnings.map{$0.toDomain()})
            
            case "ownerDoc":
                return BaseMessage(type: .ownerDoc, score: self.score, warings: self.warnings.map{$0.toDomain()})
                
            case "buildingDoc":
            
                return BaseMessage(type: .buildingDoc, score: self.score, warings: self.warnings.map{$0.toDomain()})
                
            default:
            
                return BaseMessage(type: .buildingDoc, score: self.score, warings: self.warnings.map{$0.toDomain()})
            
        }
        
        
       
    }
    
}

extension WarningDTO {
    
    func toDomain() -> Warning {
        return Warning(name: self.name, description: self.description)
    }
}
