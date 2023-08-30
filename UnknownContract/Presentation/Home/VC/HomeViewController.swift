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
    
    
    
    lazy var label = UILabel().then{
        $
        $0.attributedText = setTitle1Style("HI", textColor: .red)
        
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViews()
        configureUI()
    }
    


}

extension HomeViewController {
    
    func addSubViews(){
        view.addSubview(label)
    }
    
    func configureUI(){
        
        label.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
}
