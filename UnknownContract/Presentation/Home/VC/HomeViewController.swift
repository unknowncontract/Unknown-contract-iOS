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
    
    lazy var remindLabel = UILabel().then{
        
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.attributedText = setTitle2Style("계약 전\n확인하셨나요?", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
    }
    
    lazy var documentButton1 = DocumentButtonView(document: .d1).then{
        $0.delegate = self
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
        self.view.addSubview(remindLabel)
        
        self.titleView.addSubview(baseLine)
        self.titleView.addSubview(titleLabel)
        
        self.view.addSubview(documentButton1)
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

        
        remindLabel.snp.makeConstraints{
            
            $0.top.equalTo(titleView.snp.bottom).offset(79)
            $0.left.equalToSuperview().offset(MARGIN())
            $0.right.equalToSuperview()
            
        }
        
        documentButton1.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        
    }
}

extension HomeViewController:DocumentButtonViewDelegate{
    public func action(document: Document) {
        DEBUG_LOG(document)
    }
    
}
