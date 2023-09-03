//
//  CategoryTableViewCell.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/02.
//

import UIKit

public class CategoryTableViewCell: UITableViewCell {
    
    static let identifier:String = "CategoryTableViewCell"
    
    lazy var label = UILabel()
    
    lazy var arrowImageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    
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

public extension CategoryTableViewCell{
    
    func update (model:Warning) {
        
        label.attributedText = setBody1Style(model.name, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900)
        
        arrowImageView.image = model.isOpen ? DesignSystemAsset.Icon.arrowUp : DesignSystemAsset.Icon.arrowDown
        
    }
    
    private func addSubViews(){
        self.contentView.addSubview(label)
        self.contentView.addSubview(arrowImageView)
    
    }
    
    private func setUp(){

        
        label.snp.makeConstraints{
            $0.left.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(21)
            $0.right.equalTo(arrowImageView.snp.left)
        }
        
        arrowImageView.snp.makeConstraints{
            $0.right.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
    }
    

}
