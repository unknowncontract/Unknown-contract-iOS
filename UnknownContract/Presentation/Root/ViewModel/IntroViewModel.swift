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
        var fetchPermissionCheck:PublishSubject<Void> = PublishSubject()
        
    }
    
    public struct Output{
        var permissionResult:PublishSubject<Bool?> = PublishSubject()
        var endIntro:PublishSubject<Bool?> = PublishSubject()
    }
    
    
    public func transform(input:Input) -> Output {
        
        let output = Output()
        
        Observable.combineLatest(input.fetchPermissionCheck, PreferenceManager.$appPermission){ (_,permission) -> Bool? in
    
            return permission
        }
        .bind(to: output.permissionResult)
        .disposed(by: disposeBag)
        
        
        
        
        
        return output
        
    }
}
