//
//  ConfirmComponent.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import Foundation
import NeedleFoundation

public protocol ConfirmDependency: Dependency {
    
}

public final class ConfirmComponent: Component<ConfirmDependency> {
    
    var gptDataSource: GptDataSourceImpl {
          shared {
              GptDataSourceImpl()
          }
      }
      
      var gptRepository: any GptRepository {
          shared {
              GptRepositoryImpl(gptDataSource: gptDataSource)
          }
      }
      
      var fetchGptAnswerUseCase: any FetchGptAnswerUseCase {
          shared {
              FetchGptAnswerUseCaseImpl(repository: gptRepository)
          }
      }
    
    
    public func makeView(document:Document) -> ConfirmViewController {
        return ConfirmViewController(viewModel: ConfirmViewModel(
        fetchGptAnswerUseCase: fetchGptAnswerUseCase,document: document
        ))
        
    }
}
