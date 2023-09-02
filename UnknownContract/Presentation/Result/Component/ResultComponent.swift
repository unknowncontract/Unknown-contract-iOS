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
    

    
    public func makeView(message:String,document:Document) -> ResultViewController {
        return ResultViewController(viewModel: ResultViewModel(model: TestEntity(score: 50, document: .buildingDoc)))
        
    }
}
