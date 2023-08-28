//
//  MoiveAPI.swift
//  NetflixClone
//
//  Created by yongbeomkwak on 2023/08/25.
//

import Foundation
import Moya

public protocol BaseAPI: TargetType {
    
    var domain: String { get }
    var urlPath: String { get }
    
}

public extension BaseAPI {
    var baseURL: URL {
         URL(string: BASE_URL())!
     }
    
     var path: String {
         return "\(domain)\(urlPath)"

     }

     var headers: [String: String]? {
         ["Content-Type": "application/json"]
     }

     var validationType: ValidationType {
         return .successCodes
     }
    
}
