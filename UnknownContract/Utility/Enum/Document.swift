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
    
    var checkListContent:String {
        
        get {
            
            switch self {
                
            case .contract:
                return "계약서에 명시된 특약사항 중 임차인에게\n불리한 내용이 있는지 검토합니다."
                
            case .owner:
                return "등기부등본 발급 시, ‘매매목록'을 꼭 선택하세요.\n건물의 소유권 정보를 확인합니다.건물을 담보로 한\n채무관계와 근저당권 설정을 확인합니다."
            case .building:
                return "건축물 위반사항과 건물의 용도를 확인합니다."
            }
            
        }
        
        
        
    }
    
}
