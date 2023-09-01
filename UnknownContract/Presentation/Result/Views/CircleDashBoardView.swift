//
//  CircleDashBoardView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SnapKit
import Then




public class CircleDashBoardView: UIView {

    
    let circlePath = UIBezierPath(arcCenter: .zero, radius: 50, startAngle: -.pi, endAngle: 2 * CGFloat.pi, clockwise: true)
    // startAngle: 라인 시작
//    private lazy var trackLayer = CAShapeLayer()

    
//    private lazy var strokeView = UIView().then{
//
//
//        $0.layer.borderWidth = 1
//        $0.layer.borderColor = UIColor.blue.cgColor
//     //   $0.backgroundColor = .red
//        $0.layer.cornerRadius = 100
//
//
//    }
    
    private lazy var strokeView = UIView()
    
    
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

    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        
    }
    
    

    public override func layoutSubviews() { // Draw Cycle 관련
        super.layoutSubviews()
        addBorderCircularGradient(to:strokeView,colors: [colorFromRGB("EFEFEF").cgColor,colorFromRGB("E0E0E0",alpha: 0.3062).cgColor,colorFromRGB("DBDBDB",alpha: 0.0001).cgColor], lineWidth: 1.25, startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        
    }
    

}

public extension CircleDashBoardView {
    
    private func setUp(){
        

        
        strokeView.snp.makeConstraints{
            
            $0.center.equalToSuperview()
            $0.width.height.equalTo(200)
            
        }
        
       
        
       

    }
    
    private func addSubViews(){
        addSubview(strokeView)

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
