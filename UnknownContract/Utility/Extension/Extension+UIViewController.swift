//
//  Extension+UIViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import Foundation
import UIKit
import SwiftUI


extension UIViewController {
    
    var wrapNavigationController: UINavigationController {
          return UINavigationController(rootViewController: self)
    }
    
    
#if DEBUG
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
    

#endif
}
