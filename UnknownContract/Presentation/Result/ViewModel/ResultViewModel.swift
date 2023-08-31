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
    var document:Document!
    
    init(document: Document) {
        self.document = document
    }
    
    
    
}
