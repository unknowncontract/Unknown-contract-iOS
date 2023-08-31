//
//  CircleDashBoardView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SnapKit
import Then
import RxSwift

// EFEFEF
// E0E0E0
// DBDBDB


public protocol FunctionViewViewDelegate : AnyObject {
    func action(function:Function)
}



public class FunctionView: UIView {

    
    var function:Function?
    weak var delegate:FunctionViewViewDelegate?
    let disposeBag = DisposeBag()
    lazy var button = UIButton()
    lazy var label = UILabel()
    lazy var imageView = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    

    init(function: Function){
        super.init(frame: .zero)
        self.function = function
        self.addSubViews()
        self.setUp()
        self.event()
       
    }
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        addSubViews()
//        setUp()
        
    }
    
    public override func layoutSubviews() { // Draw Cycle 관련
        super.layoutSubviews()
        //stroke.frame = bounds
        
    }
    

}

public extension FunctionView {
    
    private func setUp(){
        
        
        guard let function = function else {return}
        
        var image = UIImage()
        let text:String = function.title
        
        switch function{
        case .camera:
            image = DesignSystemAsset.Icon.camera
        case .upload:
            image = DesignSystemAsset.Icon.gallery
        }
        
        imageView.image = image
        label.attributedText = setBody1Style(text, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900,alignment: .center)
        
        
        button.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalToSuperview().inset(32)
            $0.left.right.equalToSuperview().inset(45)
            $0.width.equalTo(70)
            $0.height.equalTo(70)
        }
        
        label.snp.makeConstraints{
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(32)
        }
        
        self.setShadow1()
        
        
    }
    
    private func addSubViews(){
        self.addSubview(button)
        self.addSubview(label)
        self.addSubview(imageView)

    }
    
    func event(){
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                self.delegate?.action(function: self.function!)
                
            })
            .disposed(by: disposeBag)
    }
    
}

