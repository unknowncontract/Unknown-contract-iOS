//
//  CircleDashBoardView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SnapKit
import Then


// EFEFEF
// E0E0E0
// DBDBDB

public class CircleDashBoardView: UIView {

    
    let circlePath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: -.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
    // startAngle: 라인 시작
//    private lazy var trackLayer = CAShapeLayer()

    
    
    private lazy var edgeLayer = CAShapeLayer().then{
        $0.path = circlePath.cgPath
        $0.lineWidth = 10
        $0.strokeColor = UIColor.red.cgColor
        $0.fillColor = UIColor.black.cgColor
    }
    

    public override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setUp()
    
        DEBUG_LOG("INIT")
        print(center)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
//        addSubViews()
//        setUp()
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        //stroke.frame = bounds
    }
    

}

public extension CircleDashBoardView {
    
    private func setUp(){

        

        
        
    }
    
    private func addSubViews(){


    }
    
    func update(){
       
    }
    
}

//let center = view.center
//
//let trackLayer = CAShapeLayer()

//
//trackLayer.path = circlePath.cgPath
//
//trackLayer.strokeColor = UIColor.lightGray.cgColor
//trackLayer.lineWidth = 10
//trackLayer.fillColor = UIColor.clear.cgColor //
//trackLayer.lineCap = .round // 선 모양
//view.layer.addSublayer(trackLayer)
//
//
//
//shapeLayer.path = circlePath.cgPath
//
//shapeLayer.strokeColor = UIColor.red.cgColor
//shapeLayer.lineWidth = 10
//shapeLayer.fillColor = UIColor.clear.cgColor //
//shapeLayer.lineCap = .round // 선 모양
//shapeLayer.strokeEnd = 0
//
//
//view.layer.addSublayer(shapeLayer)
//
//
//view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldeTap)))
//
//
//@objc private func hanldeTap(){
//    print("Hello")
//    
//    let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//    
//    basicAnimation.toValue = 1
//    basicAnimation.duration = 2
//    basicAnimation.fillMode = .forwards
//    basicAnimation.isRemovedOnCompletion = false
//    
//    shapeLayer.add(basicAnimation, forKey: "urSoBasic")
//}
