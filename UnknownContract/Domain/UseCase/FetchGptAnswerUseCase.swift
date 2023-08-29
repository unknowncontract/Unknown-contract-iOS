//
//  FetchGptAnswer.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxSwift

protocol FetchGptAnswerUseCase {
    
    func execute(question:String) -> Single<BaseMessage>
    
}
