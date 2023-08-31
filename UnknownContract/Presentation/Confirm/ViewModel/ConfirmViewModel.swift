//
//  ConfirmViewModel.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxRelay
import RxSwift

enum ImageSource {
    case camera
    case upload
}

final class ConfirmViewModel {
    
    let disposeBag = DisposeBag()
    
    
    let fetchGptAnswerUseCase:FetchGptAnswerUseCase!
    
    let document:Document!
    
    init(fetchGptAnswerUseCase: FetchGptAnswerUseCase!,document:Document) {
        self.fetchGptAnswerUseCase = fetchGptAnswerUseCase
        self.document = document
        

    }
    
    struct Input{

        let resultText:PublishRelay<String> = .init()
        
    }
    
    struct Output{
        
        
        let indicatorState:PublishRelay<Bool> = .init()
        
    }
    
    
    func transform(input:Input) -> Output {
        
        let output = Output()
        

        
        
        input.resultText
            .subscribe(onNext: { [weak self] text in
                
                guard let self else {return}
                //TODO: 서버 연결하기 
                DEBUG_LOG(text)

                
            })
            .disposed(by: disposeBag)
        

           
        
        
        
        return output
        
    }
    
}
