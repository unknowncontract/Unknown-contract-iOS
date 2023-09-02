//
//  PermissionViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import UIKit
import SnapKit
import Then
import RxSwift

public class PermissionViewController: BaseViewController {

    let disposeBag = DisposeBag()
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setTitle2Style("서비스 이용안내", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000,alignment: .center)
    }
    
    lazy var subtitleLabel = UILabel().then{
        $0.attributedText =  setBody2Style("약관에 동의해 주세요.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700, alignment: .center)
    }
    
    lazy var scrollViewContainerView = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
    
    lazy var button = UIButton().then{
        
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue800
        $0.setAttributedTitle(setTitle4Style("동의하고 시작하기", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100), for: .normal)
    }
    
    
    public override func viewDidLoad() {
        
        super.viewDidLoad()
        addSubViews()
        configureUI()
        bind()
        
    }

}

extension PermissionViewController {
    
    private func addSubViews(){
        
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(scrollViewContainerView)
        view.addSubview(button)
    }
    
    private func configureUI(){
        
        
        titleLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(32)
            
        }
        
        subtitleLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom)

        }
        
        scrollViewContainerView.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(MARGIN())
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(32)
            $0.bottom.equalTo(button.snp.top).offset(-20)
        }
        
        button.snp.makeConstraints{
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(64)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
    }
    
    private func bind(){
        
        button.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                PreferenceManager.appPermission = false //TODO: true 로 바꾸기
                
                self.dismiss(animated: true)
                
            })
            .disposed(by:disposeBag )
    }
    
}
