//
//  BaseViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        configureCommonUI()
    }
}

extension BaseViewController {
    
    /// 1. 네비게이션 바 숨김, 2. 테이블 뷰를 사용한다면 섹션헤더 간격 0으로 설정
    private func configureCommonUI() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
        if #available(iOS 15.0, *) {
            let tableViews = self.view.subviews.map { $0 as? UITableView }.compactMap { $0 }
            tableViews.forEach {
                $0.sectionHeaderTopPadding = 0
            }
        }
    }
}
