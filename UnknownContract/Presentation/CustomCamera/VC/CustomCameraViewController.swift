//
//  CustomCameraViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import UIKit
import SnapKit
import Then
import AVFoundation

public class CustomCameraViewController: BaseViewController {
    
    let bgColor = UIColor.black.withAlphaComponent(0.6)
    
    lazy var statusEmptyView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    lazy var titleView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setBody1Style("임대차계약서 촬영", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100)
    }
    
    lazy var closeButton = UIButton().then{
        
        
        $0.setImage(DesignSystemAsset.Icon.whiteClose, for: .normal)
    }
    
    
    lazy var bottomView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.post(name: .statusBarEnterDarkBackground, object: nil)
        
        addSubViews()
        configureUI()
        
    }
}

extension CustomCameraViewController{
    
    private func addSubViews(){
        
        self.view.addSubview(statusEmptyView)
        self.view.addSubview(titleView)
        self.view.addSubview(bottomView)
        
        self.titleView.addSubview(titleLabel)
        self.titleView.addSubview(closeButton)
    }
    
    
    private func configureUI(){
        
        statusEmptyView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(STATUS_BAR_HEGHIT())
        }
        
        titleView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(statusEmptyView.snp.bottom)
            $0.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.right.equalToSuperview().inset(MARGIN())
        }
        
        bottomView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            
            $0.height.equalTo(200)
        }
    }
}
