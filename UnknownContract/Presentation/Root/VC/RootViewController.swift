//
//  ViewController.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SwiftUI
import SnapKit
import Then

public class RootViewController: UIViewController {
    
    var circleDashBoardView = CircleDashBoardView()
    


    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.addSubViews()
        self.configureUI()

        
    }
    
    
}

extension RootViewController {

    private func addSubViews(){
        self.view.addSubview(circleDashBoardView)
   
    }
    private func configureUI(){
        circleDashBoardView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }


    }
}


