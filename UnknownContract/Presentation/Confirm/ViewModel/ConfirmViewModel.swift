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
    
    
    struct Input{
        
        let cameraTap:PublishSubject<Void> = .init()
        let uploadTap:PublishSubject<Void> = .init()
        let resultText:PublishRelay<String> = .init()
        
    }
    
    struct Output{
        
        
        let indicatorState:PublishRelay<Bool> = .init()
        let imageSource:PublishSubject<ImageSource> = .init()
        
        
    }
    
    
    func transform(input:Input) -> Output {
        
        let output = Output()
        
        input
            .cameraTap
            .flatMap{  
                return Observable.just(ImageSource.camera)
            }
            .bind(to: output.imageSource)
            .disposed(by: disposeBag)
        
        
        input.uploadTap
            .flatMap{
                return Observable.just(ImageSource.upload)
            }
            .bind(to: output.imageSource)
            .disposed(by: disposeBag)
        
        
        input.resultText
            .withLatestFrom(output.imageSource){($0,$1)}
            .subscribe(onNext: { [weak self] text,imageSource in
                
                guard let self else {return}
                //TODO: 서버 연결하기 
                DEBUG_LOG(text)
                DEBUG_LOG(imageSource)
                
            })
            .disposed(by: disposeBag)
        

           
        
        
        
        return output
        
    }
    
}
