//
//  Rule.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/02.
//

import Foundation


public enum Rule{
 
    case collect
    case purpose
    case period
    
    
    var title:String {
        get {
            switch self{
                
            case .collect:
                return "1. 수집하는 개인정보 항목"
            case .purpose:
                return "2. 개인정보 수집∙이용 목적"
            case .period:
                return "3. 보유 및 이용기간"
            }
        }
    }
    
    //TODO: \n 빼기
    var content:String {
        get {
            switch self{
                
            case .collect:
                return "주소"
            case .purpose:
                return "시세 확인을 위하여 활용"
            case .period:
                return "서비스 이용 종료 후 즉시 파기. 회사는 “서비스” 사용\n시 사용자의 개인정보를 이용·보관함을 원칙으로 하며\n이용 목적이 달성되면 지체 없이 파기합니다. 다만, 관\n계법령의 규정에 의하여 보존할 필요가 있는 경우 회\n사는 해당 법령에 따라 보관할 수 있습니다. 세부적인\n사항은 회사의 개인정보처리방침 (https://flax-\nallium-1f9.notion.site/9480c65c2ecc4454abff\n09b28aada42e?pvs=4) 에서 정한 바에 따릅니다."
            }
        }
    }
    
    
}
