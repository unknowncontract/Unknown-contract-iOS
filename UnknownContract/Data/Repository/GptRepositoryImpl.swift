//
//  GptRepositoryImpl.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxSwift

struct GptRepositoryImpl : GptRepository {

    
    
    private let gptDataSource: any GptDataSource
    
    
    init(gptDataSource: any GptDataSource) {
        self.gptDataSource = gptDataSource
    }
    
    func fetchGptAnswer(message: String) -> Single<BaseMessage> {
        gptDataSource.fetchGptAnswer(question: message)
    }

    
}
