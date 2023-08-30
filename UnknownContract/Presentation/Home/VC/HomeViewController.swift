//
//  HomeViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import UIKit
import SnapKit
import Then
import RxCocoa
import RxSwift

public class HomeViewController: BaseViewController {
    
    var customCameraComponent:CustomCameraComponent!
    
    let disposeBag = DisposeBag()
    
    lazy var titleView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var baseLine = UIView().then{
        
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
    lazy var titleLabel = UILabel().then{
        
        $0.attributedText = setBody1Style("모르는계약", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
    }
    
    lazy var remindLabel = UILabel().then{
        
        $0.textAlignment = .left
        $0.numberOfLines = 0
        $0.attributedText = setTitle2Style("계약 전\n확인하셨나요?", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
        
    }
    
    lazy var documentButton1 = DocumentButtonView(document: .d1).then{
        $0.delegate = self
    }
    
    lazy var documentButton2 = DocumentButtonView(document: .d2).then{
        $0.delegate = self
    }
    
    lazy var documentButton3 = DocumentButtonView(document: .d3).then{
        $0.delegate = self
    }
    
    lazy var documentStack = UIStackView().then{
        $0.axis = .horizontal
        $0.alignment = .center
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        
       // $0.layoutMargins = UIEdgeInsets(top: MARGIN(), left: MARGIN(), bottom: MARGIN(), right: MARGIN())
        $0.distribution = .equalSpacing
        //$0.spacing = 8
        
        
    }
    
    
    init(customCameraComponent:CustomCameraComponent){
        super.init(nibName: nil, bundle: nil)
        self.customCameraComponent = customCameraComponent
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        configureUI()

    }
    


}

extension HomeViewController {
    
    func addSubViews(){
        self.view.addSubview(titleView)
        self.titleView.addSubview(baseLine)
        self.titleView.addSubview(titleLabel)
        
        
    
        self.view.addSubview(remindLabel)
        
        self.view.addSubview(documentStack)
        self.documentStack.addArrangedSubview(documentButton1)
        self.documentStack.addArrangedSubview(documentButton2)
        self.documentStack.addArrangedSubview(documentButton3)
        
        
    }
    
    func configureUI(){
        
        titleView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(48)
        }
        
        baseLine.snp.makeConstraints{
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
            $0.left.right.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }

        
        remindLabel.snp.makeConstraints{
            
            $0.top.equalTo(titleView.snp.bottom).offset(79)
            $0.left.equalToSuperview().offset(MARGIN())
            $0.right.equalToSuperview()
            
        }
        
        documentStack.snp.makeConstraints{
            
            $0.left.right.equalToSuperview().inset(20)
            $0.top.equalTo(remindLabel.snp.bottom).offset(24)
            $0.bottom.equalToSuperview().inset(407)
        }
        

        
        
    }
    


}

extension HomeViewController:DocumentButtonViewDelegate{
    public func action(document: Document) {

        let vc = self.customCameraComponent.makeView()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)

    }
    
}
