//
//  CategoryTableViewCell.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/02.
//

import UIKit
import Then
import SnapKit

public class AnswerTableViewCell: UITableViewCell {
    
    static let identifier:String = "AnswerTableViewCell"
    
    lazy var topLine = UIView().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200
    }
    
    lazy var dotContainerView = UIView()
    
    lazy var dotView = UIView().then{
        $0.layer.cornerRadius = 3
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue500
    }
    
    lazy var label = UILabel()

    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
        addSubViews()
        setUp()
        setShadow2()
            
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

public extension AnswerTableViewCell{
    
    func update (model:Warning) {
        
        label.attributedText = setBody2Style(model.description, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue800)
    }
    
    private func addSubViews(){

        self.addSubview(topLine)
        self.addSubview(dotContainerView)
        self.dotContainerView.addSubview(dotView)
        self.addSubview(label)
    
    }
    
    private func setUp(){
        
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
