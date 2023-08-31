//
//  ResultViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import UIKit
import SnapKit
import Then
import RxSwift

public class ResultViewController: BaseViewController {

    
    let disposeBag = DisposeBag()
    
    lazy var navigationBarView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var backButton = UIButton().then{
        
        $0.setImage(DesignSystemAsset.Icon.arrowLeft, for: .normal)
    }
    
    lazy var navigationTitleLabel = UILabel().then{
        //TODO: 타이틀 이름 유기적으로 변경
        $0.attributedText = setBody1Style("임대차계약 검사 결과", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
    }
    
    lazy var baseLine = UILabel().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
    
    init(message:String){
        super.init(nibName: nil, bundle: nil)
        DEBUG_LOG(message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureUI()
        bind()
        


    }


}

extension ResultViewController {
    private func addSubViews(){
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
    }
    
    private func configureUI(){
        navigationBarView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints{
            $0.width.height.equalTo(32)
            $0.left.equalToSuperview().inset(MARGIN())
            $0.centerY.equalToSuperview()
        }
        
        navigationTitleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        baseLine.snp.makeConstraints{
            
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
    }
    
    private func bind(){
        backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                owner.navigationController?.popViewController(animated: true)
                
            })
            .disposed(by: disposeBag)
    }
}
