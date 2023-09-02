//
//  FetchGptAnswer.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxSwift

protocol FetchGptAnswerUseCase {
    
    func execute(type:String,data:String) -> Single<BaseMessage>
    
}
