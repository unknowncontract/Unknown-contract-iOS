//
//  ContractEnum.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation


public enum Document:String {

    
    case contract 
    case owner
    case building
    
    
    var checkNavigationTitle:String  {
        get {
            switch self {
                
            case .contract:
                return "임대차계약서 확인하기"
            case .owner:
                return "등기부등본 확인하기"
            case .building:
                return "건축물대장 확인하기"
            }
        }
    }
    
    var resultNavigationTitle:String {
        get{
            switch self {
                
            case .contract:
                return "임대차계약서 검토 결과"
            case .owner:
                return "등기부등본 검토 결과"
            case .building:
                return "건축물대장 검토 결과"
            }
        }
    }
    
    var cameraNavigationTitle:String {
        get{
            switch self {
                
            case .contract:
                return "임대차계약서 촬영"
            case .owner:
                return "등기부등본 촬영"
            case .building:
                return "건축물대장 촬영"
            }
        }
    }
    
}
