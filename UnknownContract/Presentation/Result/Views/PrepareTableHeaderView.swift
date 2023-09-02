//
//  PrepareTableHeaderView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/02.
//

import UIKit
import SnapKit
import Then

class PrepareTableHeaderView: UIView {

    
    lazy var imageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
        $0.image = DesignSystemAsset.Icon.info
        
    }
    
    lazy var label = UILabel().then{
        $0.attributedText = setBody1Style("대비가 꼭 필요한 보장", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900)
    }
    
    
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(label)
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(24)
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        label.snp.makeConstraints{
            $0.left.equalTo(imageView.snp.right).offset(4)
            $0.centerY.equalTo(imageView.snp.centerY)
        }
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
    }

}
