//
//  GptRepository.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxSwift

protocol GptRepository {
    
    func fetchGptAnsewr(message:String) -> Single<BaseMessage>
}
