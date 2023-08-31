//
//  Function.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import Foundation



public enum Function{
    
    case camera
    case upload
    
    
    var title : String {
        switch self {
            
        case .camera:
            return "카메라 촬영"
        case .upload:
            return "PDF 업로드"
        }
    }
    
    

    
}
