//
//  BaseDataSource.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import Foundation
import Moya
import RxMoya
import RxSwift

public class BaseDataSource<API:BaseAPI> {
    private let provider: MoyaProvider<API> = MoyaProvider<API>()
    private let decoder = JSONDecoder()
    private let maxRetryCount = 2
    
    
    public func request(_ api: API) -> Single<Response> {
    
            return Single<Response>.create { single in
                var disposabels = [Disposable]()
                disposabels.append(
                    self.defaultRequest(api).subscribe(
                        onSuccess: { single(.success($0)) },
                        onFailure: { single(.failure($0)) })
                )
                return Disposables.create(disposabels)
            }
    }
    

}


private extension BaseDataSource {
    func defaultRequest(_ api: API) -> Single<Response> {
       
         return provider.rx.request(api)
             .timeout(.seconds(10), scheduler: MainScheduler.asyncInstance)
             .catch { error in
                 print("H3 \(error.localizedDescription)")
                 return Single.error(error)
             }
     }
}
