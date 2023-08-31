//
//  ContractEnum.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation


public enum Document{

    
    case contractDoc
    case ownerDoc
    case buildingDoc
    
    
    var navigationTitle:String  {
        get {
            switch self {
                
            case .contractDoc:
                return "임대차계약서 확인하기"
            case .ownerDoc:
                return "등기부등본 확인하기"
            case .buildingDoc:
                return "건축물대장 확인하기"
            }
        }
    }
    
}
