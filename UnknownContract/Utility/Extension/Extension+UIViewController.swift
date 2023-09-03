//
//  Extension+UIViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import Foundation
import UIKit
import SwiftUI
import SwiftEntryKit


extension UIViewController {
    
    var wrapNavigationController: UINavigationController {
          return UINavigationController(rootViewController: self)
    }
    
    
    func showToast(text: String, font: UIFont, verticalOffset: CGFloat? = nil) {
           var attributes = EKAttributes.bottomFloat
           attributes.displayDuration = 2
           attributes.entryBackground = .color(color: EKColor(rgb: 0x101828).with(alpha: 0.8))
           attributes.roundCorners = .all(radius: 20)
           
           if let verticalOffset = verticalOffset {
               attributes.positionConstraints.verticalOffset = verticalOffset
           }

           let style = EKProperty.LabelStyle(
               font: font,
               color: EKColor(rgb: 0xFCFCFD),
               alignment: .center
           )
           let labelContent = EKProperty.LabelContent(
               text: text,
               style: style
           )

           let contentView = EKNoteMessageView(with: labelContent)
           contentView.verticalOffset = 10
           SwiftEntryKit.display(entry: contentView, using: attributes)
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
