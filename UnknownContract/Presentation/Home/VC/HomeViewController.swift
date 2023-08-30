//
//  HomeViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

public class HomeViewController: BaseViewController {
    
    
    lazy var titleView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var baseLine = UIView().then{
        
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
    lazy var titleLabel = UILabel().then{
        
        $0.attributedText = setBody1Style("모르는계약", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        

    }
    

    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        configureUI()
    }
    


}

extension HomeViewController {
    
    func addSubViews(){
        self.view.addSubview(titleView)
        
        
        self.titleView.addSubview(baseLine)
        self.titleView.addSubview(titleLabel)
    }
    
    func configureUI(){
        
        titleView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        baseLine.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }

    }
}
