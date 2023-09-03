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
    
    
    func showToast(text: String =  "문제가 발생했습니다. 다시 시도해 주세요.",  verticalOffset: CGFloat? = nil) {
           var attributes = EKAttributes.bottomFloat
           attributes.displayDuration = 2
           attributes.entryBackground = .color(color: EKColor(rgb: 0x1B2739).with(alpha: 1.0))
           attributes.roundCorners = .all(radius: 20)
           
           if let verticalOffset = verticalOffset {
               attributes.positionConstraints.verticalOffset = verticalOffset
           }

           let style = EKProperty.LabelStyle(
               font: DesignSystemAsset.Pretendard.body2,
               color: EKColor(rgb: 0xFAFAFB),
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
