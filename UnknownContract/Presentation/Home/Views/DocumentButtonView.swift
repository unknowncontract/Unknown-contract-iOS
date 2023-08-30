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


public protocol DocumentButtonViewDelegate : AnyObject {
    func action(document:Document)
}



public class DocumentButtonView: UIView {

    
    var document:Document?
    weak var delegate:DocumentButtonViewDelegate?
    let disposeBag = DisposeBag()
    lazy var button = UIButton()
    lazy var label = UILabel()
    

    init(document: Document){
        super.init(frame: .zero)
        self.document = document
        DEBUG_LOG(document)
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

public extension DocumentButtonView {
    
    private func setUp(){
        
        
        guard let document = document else {return}
        
        var image = UIImage()
        var text:String = ""
        
        switch document{

        case .d1:
            image = UIImage(systemName: "heart")!
            text = "임대차계약서"
            
        case .d2:
            image = UIImage(systemName: "home")!
            text = "등기부등본"
        case .d3:
            image = UIImage(systemName: "person")!
            text = "건축물대장"
            
        }
        
        button.setImage(image, for: .normal)
        label.attributedText = setBody1Style(text, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue900)
        
        
        button.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
        
        label.snp.makeConstraints{
            $0.top.equalTo(button.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
        }
        
        
    }
    
    private func addSubViews(){
        self.addSubview(button)
        self.addSubview(label)

    }
    
    func event(){
        button.rx.tap
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                self.delegate?.action(document: self.document!)
                
            })
            .disposed(by: disposeBag)
    }
    
}

