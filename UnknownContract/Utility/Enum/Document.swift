//
//  ContractEnum.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation


public enum Document{
    
    case d1
    case d2
    case d3
    
    
    var navigationTitle:String  {
        get {
            switch self {
                
            case .d1:
                return "임대차계약서 확인하기"
            case .d2:
                return "등기부등본 확인하기"
            case .d3:
                return "건축물대장 확인하기"
            }
        }
    }
    
}
