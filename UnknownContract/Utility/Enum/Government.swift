//
//  Government.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation

public enum Government:String{
    
    case court = "Court"
    case gov = "Gov"
    
    
    var dept : String {
        
        switch self {
            
        case .court:
            return "대한민국 법원 인터넷 등기소"
        case .gov:
            return "정부24"
        }
    }
    
    var title : String {
        
        switch self {
            
        case .court:
            return "등기부등본 발급"
        case .gov:
            return "건축물대장 발급"
        }
        
    }
    
}
