//
//  ResultComponent.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//


import Foundation
import NeedleFoundation

public protocol ResultDependenvy: Dependency {
    
}

public final class ResultComponent: Component<ResultDependenvy> {
    

    
    public func makeView(message:String) -> ResultViewController {
        return ResultViewController(message: message)
        
    }
}
