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
    
    lazy var imageView = UIImageView().then{
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named: "SplashLogo")
        
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
        self.view.addSubview(imageView)
    }
    
    private func configureUI(){
        imageView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private func inputBind() {
           input.fetchInitPermissionCheck.onNext(())
       }
    
    private func outputBind(){

        output.permissionResult
            .do(onNext: { [weak self] (permission) in
                    guard let self = self else { return }
                    let show: Bool = !(permission ?? false)
                    guard show else { return }
                    let permission = self.permissionComponent.makeView()
                permission.modalPresentationStyle =  .fullScreen
                    self.present(permission, animated: true)
            })
            .filter { return ($0 ?? false) == true }
            .map{ _ in ()}
            .bind(to: input.fetchFinalPermissionCheck)
            .disposed(by: disposeBag)
        
        
        output.endIntro
            .delay(.seconds(1), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self]  in
                guard let self else {return}

                
                let home = self.homeComponent.makeView()
                
                self.navigationController?.pushViewController(home, animated: false)
                
            })
            .disposed(by: disposeBag)
        }
    

        
}






