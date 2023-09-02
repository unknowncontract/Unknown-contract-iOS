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
    
    lazy var scrollView = UIScrollView()
    
    lazy var stackView = UIStackView().then{
        $0.spacing = 16
        $0.axis = .vertical
    }
    
    lazy var serviceContarctTitleLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.attributedText = setBody3Style("아는게 힘㈜(이하 “회사“)는 모르는계약(이하 “서비스”)의 이용을 위\n해 “서비스”를 이용하는 사용자의 개인정보를 아래와 같이 수집·이용\n합니다.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700)
    }
    
    lazy var ruleView1 = RuleView(rule: .collect).then{
        $0.backgroundColor = .red
    }
    lazy var ruleView2 = RuleView(rule: .purpose).then{
        $0.backgroundColor = .green
    }
    lazy var ruleView3 = RuleView(rule: .period).then{
        $0.backgroundColor = .orange
    }
    
    lazy var waringComentLabel = UILabel().then{
        
        $0.numberOfLines = 0
        $0.attributedText = setBody3Style("사용자는 수집/이용 동의를 거부할 수 있으나, 이에 동의하지 않을 경\n우 서비스 이용이 제한될 수 있습니다.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700)
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
        scrollViewContainerView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(serviceContarctTitleLabel)
        stackView.addArrangedSubview(ruleView1)
        stackView.addArrangedSubview(ruleView2)
        stackView.addArrangedSubview(ruleView3)
        stackView.addArrangedSubview(waringComentLabel)
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
        
        scrollView.snp.makeConstraints{
            $0.top.left.right.bottom.equalToSuperview().inset(16)
        }
        
        stackView.snp.makeConstraints{
            $0.edges.equalToSuperview()
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
                
                PreferenceManager.appPermission = true 
                
                self.dismiss(animated: true)
                
            })
            .disposed(by:disposeBag )
    }
    
}
