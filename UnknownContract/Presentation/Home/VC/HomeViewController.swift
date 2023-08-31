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
    
    lazy var gradientView = UIView()
    
    lazy var remindLabel1 = UILabel().then{
        
        $0.attributedText = setTitle2Style("계약 전", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100.withAlphaComponent(0.4),alignment: .center)
    }
    
    lazy var remindLabel2 = UILabel().then{
        
        $0.attributedText = setTitle1Style("확인하셨나요?", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100,alignment: .center)
        
    }
    
    lazy var commentLabel = UILabel().then{
        $0.attributedText = setBody2Style("확인하고 싶은 서류를 선택해 주세요", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100,alignment: .center)
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
    
    lazy var stackContainer = UIView().then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
    }
    
    lazy var documentStack = UIStackView().then{
        $0.alignment = .center
        $0.axis = .horizontal
      
        
        //$0.layoutMargins = UIEdgeInsets(top: MARGIN(), left: MARGIN(), bottom: MARGIN(), right: MARGIN())
        $0.distribution = .fillEqually
        $0.spacing = 8
        
        
    }
    
    lazy var courtView = GovernmentButtonView(gov: .court).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.delegate = self
    }
    
    lazy var govView = GovernmentButtonView(gov: .gov).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.delegate = self
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
    
    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            let gradient: CAGradientLayer = CAGradientLayer()

            let color1 = colorFromRGB("1B2739")
            let color2 = colorFromRGB("506179")

            gradient.colors = [color1.cgColor,color2.cgColor]
            gradient.locations = [0.0 , 1.0]
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)



            gradient.frame = gradientView.bounds
            gradientView.layer.addSublayer(gradient)
    }
    
    public override var preferredStatusBarStyle: UIStatusBarStyle { //DARK MODE
        return  .lightContent
    }
    


}

extension HomeViewController {
    
    func addSubViews(){

        
        self.view.addSubview(gradientView)
        self.view.addSubview(remindLabel1)
        self.view.addSubview(remindLabel2)
        self.view.addSubview(commentLabel)
        self.view.addSubview(stackContainer)
        self.view.addSubview(courtView)
        self.view.addSubview(govView)
        
        self.stackContainer.addSubview(documentStack)
        self.documentStack.addArrangedSubview(documentButton1)
        self.documentStack.addArrangedSubview(documentButton2)
        self.documentStack.addArrangedSubview(documentButton3)
        
    
        
        
    }
    
    func configureUI(){
        
        
        gradientView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.right.equalToSuperview()
            $0.bottom.equalTo(documentStack.snp.bottom).inset(56)
        }
        
        remindLabel1.snp.makeConstraints{
            $0.top.equalToSuperview().inset(60)
            $0.left.right.equalToSuperview()
            
        }
        
        remindLabel2.snp.makeConstraints{
            
            $0.top.equalTo(remindLabel1.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            
        }
        
        commentLabel.snp.makeConstraints{
            $0.top.equalTo(remindLabel2.snp.bottom).offset(24)
            $0.left.right.equalToSuperview()
        }
        
        
        stackContainer.snp.makeConstraints{
            
            $0.top.equalTo(commentLabel.snp.bottom).offset(32)
            $0.left.right.equalToSuperview().inset(20)
            $0.height.equalTo(140) //TODO:  수정예쩡
            
        }
        
        documentStack.snp.makeConstraints{
            
            $0.left.right.equalToSuperview().inset(20)
            
            $0.bottom.top.equalToSuperview()    
        }
        
        
        courtView.snp.makeConstraints{
            $0.top.equalTo(documentStack.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        govView.snp.makeConstraints{
            $0.top.equalTo(courtView.snp.bottom).offset(10)
            $0.left.right.equalToSuperview().inset(20)
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

extension HomeViewController:GovernmentButtonViewDelegate{
    public func action(gov: Government) {
        DEBUG_LOG(gov)
    }
    
    
}
