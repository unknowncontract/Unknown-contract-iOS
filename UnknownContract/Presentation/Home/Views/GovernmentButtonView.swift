//
//  GovermentButtonView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

public protocol GovernmentButtonViewDelegate : AnyObject {
    func action(gov:Government)
}

class GovernmentButtonView: UIView {

    let disposeBag = DisposeBag()
    var gov:Government?
    
    weak var delegate:GovernmentButtonViewDelegate?
    
    lazy var imageView = UIImageView().then{
        $0.contentMode = .scaleToFill
    }
    
    lazy var govLabel = UILabel().then{
        $0.numberOfLines = 0
    }
    
    lazy var serviceLabel = UILabel().then{
        $0.numberOfLines = 0
    }
    
    lazy var rightArrowImage = UIImageView().then{
        
        $0.contentMode = .scaleToFill
        $0.image = DesignSystemAsset.Icon.arrowRight
    }
    
    lazy var button = UIButton()
    
    init(gov: Government ){
        super.init(frame: .zero)
 
        self.gov = gov
        self.addSubViews()
        self.setUp()
        self.event()
       
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
    }
    
    public override func layoutSubviews() { // Draw Cycle 관련
        super.layoutSubviews()
        
    }
        
}

extension GovernmentButtonView {
 
    private func addSubViews(){
        
        addSubview(imageView)
        addSubview(button)
        addSubview(rightArrowImage)
        addSubview(govLabel)
        addSubview(serviceLabel)
        
    }
    
    private func setUp(){
        
        guard let gov = gov else {return}
        
        imageView.image = UIImage(named: gov.rawValue)
        govLabel.attributedText = setBody3Style(gov.dept, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue600)
        serviceLabel.attributedText = setBody1Style(gov.title, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900)
        
        imageView.snp.makeConstraints{
            $0.left.equalToSuperview().inset(24)
            $0.top.bottom.equalToSuperview().inset(16)
            $0.width.height.equalTo(48)
        }
        
        govLabel.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.top)
            $0.left.equalTo(imageView.snp.right).offset(10)
        }
        
        serviceLabel.snp.makeConstraints{
            $0.top.equalTo(govLabel.snp.bottom).offset(4)
            $0.left.equalTo(govLabel.snp.left)
        }
        
        rightArrowImage.snp.makeConstraints{
            $0.width.height.equalTo(24)
            
            $0.centerY.equalTo(imageView.snp.centerY)
            $0.right.equalToSuperview().inset(24)
        }
        
        
        
        
        
    }
    
    private func event(){
        button.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                owner.delegate?.action(gov: owner.gov!)
            })
            .disposed(by: disposeBag)
    }
}
