//
//  GptDataSourceImpl.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//
import Foundation
import RxSwift


class GptDataSourceImpl: BaseDataSource<GptAPI>,GptDataSource {
    
    func fetchGptAnswer(question: String) -> Single<BaseMessage> {
        
        request(.baseQuestion(message:question))
            .map(BaseMessageDTO.self)
            .map{$0.toDomain()}
        
    }
    

    
   
    
    
}
