//
//  ViewController.swift
//  Unknown contract
//
//  Created by yongbeomkwak on 2023/08/28.
//

import UIKit
import SwiftUI

public class RootViewController: UIViewController {

    
    let shapeLayer = CAShapeLayer()
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        
        
        
        
        let center = view.center
        
        let trackLayer = CAShapeLayer()
        let circlePath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -.pi, endAngle: 2 * CGFloat.pi, clockwise: true) // startAngle: 라인 시작
        
        trackLayer.path = circlePath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor //
        trackLayer.lineCap = .round // 선 모양
        view.layer.addSublayer(trackLayer)
        
        
        
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor //
        shapeLayer.lineCap = .round // 선 모양
        shapeLayer.strokeEnd = 0
        
        
        view.layer.addSublayer(shapeLayer)
        
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hanldeTap)))
    }


}

extension RootViewController {
    @objc private func hanldeTap(){
        print("Hello")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
}


struct RootViewController_Previews: PreviewProvider {
    static var previews: some View {
        RootViewController().toPreview()
    }
}
