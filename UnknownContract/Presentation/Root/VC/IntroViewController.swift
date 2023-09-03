//
//  ViewController.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SwiftUI
import SnapKit
import Then
import RxSwift
import RxCocoa

public class IntroViewController: BaseViewController {
    
    var permissionComponent: PermissionComponent!
    var homeComponent: HomeComponent!

    let disposeBag = DisposeBag()
    
    private var viewModel:IntroViewModel!
    lazy var input = IntroViewModel.Input()
    lazy var output = viewModel.transform(input: input)
    
    lazy var containerView = UIView()
    
    lazy var imageView = UIImageView().then{
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "SplashLogo")
        
    }
    
    lazy var appNameLabel = UILabel().then{
        $0.attributedText = setTitle2Style("모르는계약", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900,alignment: .center)
    }
    
    
    init(permissionComponent: PermissionComponent,homeComponent:HomeComponent,viewModel:IntroViewModel) {
        self.permissionComponent = permissionComponent
        self.homeComponent = homeComponent
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureUI()
        outputBind()
        inputBind()

    }
    
    
}

extension IntroViewController {

    private func addSubViews(){

        self.view.addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(appNameLabel)
    }
    
    private func configureUI(){
        
        containerView.alpha = .zero
        
        containerView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(195)
            $0.leading.right.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.width.height.equalTo(105)
            $0.centerX.equalToSuperview()
        }
        
        appNameLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom)
        }
    }
    
    private func inputBind() {
           input.fetchInitPermissionCheck.onNext(())
       }
    
    private func outputBind(){
        //TODO:  Fade InOUT
        output.permissionResult
            .do(onNext: { [weak self] (permission) in
                    guard let self = self else { return }
                    let show: Bool = !(permission ?? false)
                    guard show else { return }
                    let permission = self.permissionComponent.makeView()
                    permission.modalPresentationStyle =  .fullScreen
                    self.present(permission, animated: false)
            })
            .filter { return ($0 ?? false) == true }
            .map{ _ in ()}
            .bind(to: input.fetchFinalPermissionCheck)
            .disposed(by: disposeBag)
        
        
        output.endIntro
            .withUnretained(self)
            .delay(.milliseconds(500), scheduler: MainScheduler.instance)
            .do(onNext: { (owner,_) in
                owner.containerView.fadeIn()
            })
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .do(onNext: { (owner,_) in
                owner.containerView.fadeOut()
            })
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { (owner,_) in
           
                let home = owner.homeComponent.makeView()
                
                owner.navigationController?.pushViewController(home, animated: false)
                
            })
            .disposed(by: disposeBag)
        }
    

        
}






