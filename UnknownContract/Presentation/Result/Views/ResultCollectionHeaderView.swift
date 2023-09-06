//
//  ResultCollectionHeaderView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/06.
//

import UIKit
import SnapKit
import Then

class ResultCollectionHeaderView: UIView {
    
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setTitle2Style("나에게 부족한 보장", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000,alignment: .center)
        
        $0.backgroundColor = .clear
    }
    
    lazy var remindLabel = UILabel().then{
        $0.attributedText = setBody2Style("꼼꼼하게 점검해보세요", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700,alignment: .center)
        $0.backgroundColor = .clear
    }
    
    lazy var dashBoardContainerView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var circleDashBoard = CircleDashBoardView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var emptyView = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }
    
    lazy var tableHeaderView = PrepareTableHeaderView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }


    public init(score:Int){
        super.init(frame: .zero)
        addSubViews()
        setUp()
        circleDashBoard.loadProgress(score)
        self.backgroundColor =  DesignSystemAsset.AntarcticBlue.antarcticBlue100
        
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
    }
    
}

extension ResultCollectionHeaderView {
    
    private func addSubViews(){
        
        self.addSubview(titleLabel)
        self.addSubview(remindLabel)
        self.addSubview(dashBoardContainerView)
        self.dashBoardContainerView.addSubview(circleDashBoard)
        self.addSubview(emptyView)
        self.addSubview(tableHeaderView)
    }
    
    private func setUp(){
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview()
        }
        
        remindLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.left.right.equalToSuperview()
        }
        
        dashBoardContainerView.snp.makeConstraints{
            $0.top.equalTo(remindLabel.snp.bottom).offset(34)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(250)
        }
        
        circleDashBoard.snp.makeConstraints{
            $0.height.equalTo(244)
            $0.center.equalToSuperview()
        }
        
        
        emptyView.snp.makeConstraints{
            $0.top.equalTo(dashBoardContainerView.snp.bottom).offset(24)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(24)
        }
        
        tableHeaderView.snp.makeConstraints{
            
            $0.top.equalTo(emptyView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(30)
        
        }
        
        
        
        
        
    }
}
