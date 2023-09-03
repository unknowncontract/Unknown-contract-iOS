//
//  ConfirmViewModel.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import RxRelay
import RxSwift



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
        
        
        let startLottie:PublishRelay<Void> = .init()
        let answerText:PublishRelay<BaseMessage> = .init()
        let showToast:PublishRelay<Void> = .init()
        
    }
    
    
    func transform(input:Input) -> Output {
        
        let output = Output()
        

        
        
        input.resultText
            .flatMap({[weak self] text -> Observable<BaseMessage> in
                
                guard let self else {return Observable.empty()}
                
                return self.fetchGptAnswerUseCase
                    .execute(type: self.document.rawValue, data: text)
                    .asObservable()
                    .catchAndReturn(BaseMessage(type: .owner, score: -1, warings: []))
            })
            .do(onNext: {
                if $0.score == -1{
                    output.showToast.accept(())
                }
            })
            .filter({$0.score != -1})
            .bind(to: output.answerText)
            .disposed(by: disposeBag)
        

           
        
        
        
        return output
        
    }
    
}
