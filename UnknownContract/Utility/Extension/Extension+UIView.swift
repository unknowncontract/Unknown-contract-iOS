//
//  Extension+UIView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import Foundation
import UIKit


extension UIView{
    func setGradient(color1:UIColor,color2:UIColor){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [color1.cgColor,color2.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = bounds
        layer.addSublayer(gradient)
    }
    
    func setShadow1(){
        
        self.layer.shadowColor = colorFromRGB("506179").cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 20
        self.layer.shadowOffset = CGSize(width: 0, height: 4) // 그림자 위치 이동 : 밑으로 4 point 이동

        self.layer.masksToBounds = false
    }
    
    func setShadow2(){
        self.layer.shadowColor = colorFromRGB("506179").cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자 위치 이동 : 밑으로 2 point 이동

        self.layer.masksToBounds = false
    }
  
}
