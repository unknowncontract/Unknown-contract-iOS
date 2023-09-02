//
//  ResultViewModel.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import Foundation
import RxSwift

final class ResultViewModel {
    
    let disposeBag = DisposeBag()
    var model:TestEntity
    
    init(model: TestEntity) {
        self.model = model
    }
    
    
    
}
