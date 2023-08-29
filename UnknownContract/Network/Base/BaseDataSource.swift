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
    
        DEBUG_LOG("\(api.baseURL)\(api.domain)\(api.urlPath)")
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
             .catch { error in
                 return Single.error(error)
             }
     }
}
