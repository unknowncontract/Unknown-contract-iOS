//
//  IntroViewModel.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation
import RxSwift
import RxCocoa


final class IntroViewModel {
    let disposeBag = DisposeBag()
    
    
    public struct Input {
        var fetchInitPermissionCheck:PublishSubject<Void> = PublishSubject()
        var fetchFinalPermissionCheck:PublishSubject<Void> = PublishSubject()
    }
    
    public struct Output{
        var permissionResult:PublishSubject<Bool?> = PublishSubject()
        var endIntro:PublishSubject<Void> = PublishSubject()
    }
    
    
    public func transform(input:Input) -> Output {
        
        let output = Output()
        
        Observable.combineLatest(input.fetchInitPermissionCheck, PreferenceManager.$appPermission){ (_,permission) -> Bool? in
    
            return permission
        }
        .bind(to: output.permissionResult)
        .disposed(by: disposeBag)
        
        
    
        input.fetchFinalPermissionCheck
            .filter({
                // 구구님께 질문
                guard let permission = PreferenceManager.appPermission else { return false }
                
                return permission
            })
            .map{ _ in ()}
            .bind(to: output.endIntro)
            .disposed(by: disposeBag)
        
        
        
        
        return output
        
    }
}
