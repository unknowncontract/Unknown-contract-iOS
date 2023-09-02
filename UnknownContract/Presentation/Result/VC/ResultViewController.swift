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
    
    private var viewModel:ResultViewModel!

    lazy var navigationBarView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var backButton = UIButton().then{
        
        $0.setImage(DesignSystemAsset.Icon.arrowLeft, for: .normal)
    }
    
    lazy var navigationTitleLabel = UILabel()
    
    lazy var baseLine = UILabel().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }

    lazy var scrollView = UIScrollView().then{
        $0.showsHorizontalScrollIndicator = false
        $0.showsVerticalScrollIndicator = false
    }
    
    lazy var stackView = UIStackView().then{
        $0.axis = .vertical
    }
    
    lazy var topLabelContainerView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setTitle2Style("나에게 부족한 보장", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000,alignment: .center)
    }
    
    lazy var remindLabel = UILabel().then{
        $0.attributedText = setBody2Style("꼼꼼하게 점검해보세요", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700,alignment: .center)
    }
    
    lazy var dashBoardContainerView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var circleDashBoard = CircleDashBoardView()
    
    lazy var dummyView = UIView().then{
        $0.backgroundColor = .blue
    }
    
    
    init(viewModel:ResultViewModel){
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureUI()
        bind()
        
        circleDashBoard.loadProgress(self.viewModel.model.score)


    }
    
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
        
    }
    
    
    
    
    
    


}

extension ResultViewController {
    private func addSubViews(){
        self.view.addSubview(navigationBarView)
        self.view.addSubview(scrollView)
        
        
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
        
        navigationTitleLabel.attributedText = setBody1Style(viewModel.model.document.resultNavigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
        
        
        self.scrollView.addSubview(stackView)
        self.stackView.addArrangedSubview(topLabelContainerView)
        self.stackView.addArrangedSubview(dashBoardContainerView)
        self.stackView.addArrangedSubview(dummyView)
        
        self.topLabelContainerView.addSubview(titleLabel)
        self.topLabelContainerView.addSubview(remindLabel)
        
        
        self.dashBoardContainerView.addSubview(circleDashBoard)
        
        
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
        
        scrollView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(navigationBarView.snp.bottom)
        }
        
        stackView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview()
        
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(20)

        }
        
        remindLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.left.right.bottom.equalToSuperview().inset(20)
            
        }
        
        dashBoardContainerView.snp.makeConstraints{
            $0.height.equalTo(244)
        }
        
        circleDashBoard.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.height.equalTo(244)
            $0.centerX.equalToSuperview()
            
        }
        
        dummyView.snp.makeConstraints{
            $0.height.equalTo(800)
            $0.left.right.equalToSuperview()
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
