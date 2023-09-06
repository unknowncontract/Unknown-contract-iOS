//
//  CategoryCollectionViewCell.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/06.
//

import UIKit

public class CategoryCollectionViewCell: UICollectionViewCell {
 
    
    static let identifier:String = "CategoryCollectionViewCell"
    
    lazy var containerView = UIView()
    
    lazy var fakeView = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }
    lazy var label = UILabel().then{
        $0.numberOfLines = 0
    }
    
    lazy var arrowImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
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

extension CategoryCollectionViewCell {
    func update (model:Warning) {
        
        label.attributedText = setBody1Style(model.name, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900)
        
        containerView.layer.cornerRadius = 10
        containerView.backgroundColor = .white
        
        if model.isOpen {
            containerView.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
        
        containerView.clipsToBounds = true
        
        
        arrowImageView.image = model.isOpen ? DesignSystemAsset.Icon.arrowUp : DesignSystemAsset.Icon.arrowDown
        
    }
    
    private func addSubViews(){
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(fakeView)
        self.containerView.addSubview(label)
        self.containerView.addSubview(arrowImageView)
    
    }
    
    private func setUp(){
        
        fakeView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(10)
        }
    
        containerView.snp.makeConstraints{
            $0.top.equalTo(fakeView.snp.bottom)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        
        label.snp.makeConstraints{
            $0.left.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(21)
            $0.right.equalTo(arrowImageView.snp.left)
        }
        
        arrowImageView.snp.makeConstraints{
            $0.width.height.equalTo(24)
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
    }
}
