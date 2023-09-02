//
//  GptDataSourceImpl.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//
import Foundation
import RxSwift


class GptDataSourceImpl: BaseDataSource<GptAPI>,GptDataSource {
    
    func fetchGptAnswer(type:String,data: String) -> Single<BaseMessage> {
        
        request(.baseQuestion(type: type, data: data))
            .map(BaseMessageDTO.self)
            .map{$0.toDomain()}
        
    }
    

    
   
    
    
}
