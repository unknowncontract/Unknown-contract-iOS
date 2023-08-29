//
//  GptDataSource.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxSwift

protocol GptDataSource {
    
    func fetchGptAnswer(question:String) -> Single<BaseMessage>

    
}
