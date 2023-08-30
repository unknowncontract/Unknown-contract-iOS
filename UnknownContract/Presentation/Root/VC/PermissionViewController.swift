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
    
    lazy var button = UIButton().then{
        $0.backgroundColor = .black
        $0.setTitle("허용", for: .normal)
    }
    
    
    public override func viewDidLoad() {
        
        DEBUG_LOG("PERM")
        super.viewDidLoad()
        addSubViews()
        configureUI()
        bind()
        
    }

}

extension PermissionViewController {
    
    private func addSubViews(){
        view.addSubview(button)
    }
    
    private func configureUI(){
        
        button.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
    private func bind(){
        
        button.rx.tap
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                PreferenceManager.appPermission = true
                
                self.dismiss(animated: false)
                
            })
            .disposed(by:disposeBag )
    }
    
}
