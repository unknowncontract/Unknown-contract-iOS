//
//  FetchGptAnswerImpl.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxSwift

public struct FetchGptAnswerUseCaseImpl: FetchGptAnswerUseCase {

    

    
    private let repository: any GptRepository

    init(
        repository: GptRepository
    ) {
        self.repository = repository
    }
    
    func execute(type:String,data:String) -> Single<BaseMessage> {
        repository.fetchGptAnswer(type: type, data: data)
    }



}
