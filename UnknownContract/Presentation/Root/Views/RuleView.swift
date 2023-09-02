//
//  RuleView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/02.
//

import UIKit
import SnapKit
import Then

class RuleView: UIView {

    var rule:Rule!
    
    lazy var ruleTilteLabelView = UILabel().then{
        $0.numberOfLines = 0
    }
    
    
    lazy var containerView = UIView()
    lazy var ruleContentLabelView = UILabel().then{
        $0.numberOfLines = 0
        
    }
    
    lazy var dotContainerView = UIView()
    
    lazy var dotView = UIView().then{
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue500
    }
    
    init(rule:Rule){
        super.init(frame: .zero)
        self.rule = rule
        
        self.addSubViews()
        
        
        self.setUp()

       
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
    }

}

extension RuleView {
    
    private func addSubViews(){
        
        self.addSubview(ruleTilteLabelView)
        self.addSubview(containerView)
        self.containerView.addSubview(dotContainerView)
        self.dotContainerView.addSubview(dotView)
        self.containerView.addSubview(ruleContentLabelView)

    }
    
    private func setUp(){
        
        ruleTilteLabelView.snp.makeConstraints{
            
            $0.top.leading.right.equalToSuperview()
            
        }
        
        containerView.snp.makeConstraints{
            $0.top.equalTo(ruleTilteLabelView.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview()
        }
        
        dotContainerView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.width.height.equalTo(16)
            $0.top.equalToSuperview().inset(1)
        }
        
        dotView.snp.makeConstraints{

            $0.width.height.equalTo(6)
            $0.centerY.equalToSuperview()
            
        }
        
        ruleContentLabelView.snp.makeConstraints{
            $0.bottom.right.top.equalToSuperview()
            $0.left.equalTo(dotContainerView.snp.right)
            
        }
        
        
        ruleTilteLabelView.attributedText = setBody1Style(rule.title, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700)
        ruleContentLabelView.attributedText = setBody2Style(rule.content, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700)
    }
    
}
