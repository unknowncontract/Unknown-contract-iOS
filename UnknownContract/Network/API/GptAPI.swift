//
//  GptAPI.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import Moya


public struct Question:Encodable {
    let type:String
    let data:String
}

public enum GptAPI{
    case baseQuestion(type:String, data:String)
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
            
        case .baseQuestion(type: let type,  data: let data):
            return .requestJSONEncodable(Question(type: type, data: data))
        }
        
    }
    
    
}
