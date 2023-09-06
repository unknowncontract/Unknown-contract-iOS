//
//  CategoryCollectionViewCell.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/06.
//

import UIKit

public class AnswerCollectionViewCell: UICollectionViewCell {
 
    
    static let identifier:String = "AnswerCollectionViewCell"

    
    lazy var contanierView = UIView()
    
    lazy var topLine = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }
    
    lazy var dotContainerView = UIView()
    
    lazy var dotView = UIView().then{
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue500
    }
    
    lazy var label = UILabel().then{
        $0.numberOfLines = 0
    }
    
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViews()
        setUp()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public extension AnswerCollectionViewCell{
    
    func update (model:Warning) {
        
        label.attributedText = setBody2Style(model.description, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue800)
        
        contanierView.layer.cornerRadius = 10
        contanierView.backgroundColor = model.isOpen ? .white : .clear
        contanierView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        contanierView.clipsToBounds = true
    }
    
    private func addSubViews(){
        self.contentView.addSubview(contanierView)
        self.contanierView.addSubview(topLine)
        self.contanierView.addSubview(dotContainerView)
        self.dotContainerView.addSubview(dotView)
        self.contanierView.addSubview(label)
    
    }
    
    private func setUp(){
        
        contanierView.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview()
        }
        
        topLine.snp.makeConstraints{
            $0.left.top.right.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        dotContainerView.snp.makeConstraints{
            $0.left.equalToSuperview().inset(20)
            $0.width.height.equalTo(16)
            $0.top.equalTo(label.snp.top).inset(2)
        }
        
        dotView.snp.makeConstraints{

            $0.width.height.equalTo(6)
            $0.centerY.equalToSuperview()
            
        }
        
        label.snp.makeConstraints{
            $0.bottom.right.top.equalToSuperview().inset(20)
            $0.left.equalTo(dotContainerView.snp.right)
            
        }
        

        
    }
    

}
