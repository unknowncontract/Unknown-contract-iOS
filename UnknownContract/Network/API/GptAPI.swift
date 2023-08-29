//
//  GptAPI.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import Moya


public struct Question:Encodable {
    let message:String
}

public enum GptAPI{
    case baseQuestion(message:String)
}

extension GptAPI :BaseAPI {
    public var domain: String {
        "/question"
    }
    
    public var urlPath: String {
        ""
    }
    
    public var method: Moya.Method {
        
        switch self {
            
        case .baseQuestion:
            return .post
        }
        
        
    }
    
    public var task: Task {
        
        switch self {
            
        case .baseQuestion(message: let message):
            return .requestJSONEncodable(Question(message: message))
        }
        
    }
    
    
}
