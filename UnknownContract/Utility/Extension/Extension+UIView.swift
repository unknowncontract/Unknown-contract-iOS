//
//  Extension+UIView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/31.
//

import Foundation
import UIKit


public func addBorderCircularGradient(to view: UIView,colors:[CGColor], lineWidth: CGFloat, startPoint: CGPoint, endPoint: CGPoint) {
    //This will make view border circular
    view.layer.cornerRadius = view.bounds.size.height / 2.0
    
    //This will hide the part outside of border, so that it would look like circle
    view.clipsToBounds = true
    
    //Create object of CAGradientLayer
    let gradient = CAGradientLayer()
    
    //Assign origin and size of gradient so that it will fit exactly over circular view
    gradient.frame = view.bounds
    
    //Pass the gredient colors list to gradient object
    gradient.colors = colors
    
    //Point from where gradient should start
    gradient.startPoint = startPoint
    
    //Point where gradient should end
    gradient.endPoint = endPoint
    
    //Now we have to create a circular shape so that it can be added to view’s layer
    let shape = CAShapeLayer()
    
    //Width of circular line
    shape.lineWidth = lineWidth
    
    //Create circle with center same as of center of view, with radius equal to half height of view, startAngle is the angle from where circle should start, endAngle is the angle where circular path should end
    
    shape.path = UIBezierPath(
    arcCenter: CGPoint(x: view.bounds.height/2,
    y: view.bounds.height/2),
    radius: view.bounds.height/2,
    startAngle: CGFloat(0),
    endAngle:CGFloat(CGFloat.pi * 2),
    clockwise: true).cgPath
    
    //the color to fill the path’s stroked outline
    shape.strokeColor = UIColor.black.cgColor
    //The color to fill the path
    shape.fillColor = UIColor.clear.cgColor
    //Apply shape to gradient layer, this will create gradient with circular border
    gradient.mask = shape
    //Finally add the gradient layer to out View
    view.layer.addSublayer(gradient)
}

extension UIView{
    
    
    func setShadow1(){
        
        self.layer.shadowColor = colorFromRGB("506179",alpha: 0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 4) // 그림자 위치 이동 : 밑으로 4 point 이동

        self.layer.masksToBounds = false
    }
    
    func setShadow2(){
        self.layer.shadowColor = colorFromRGB("506179",alpha:0.1).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 2
        self.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자 위치 이동 : 밑으로 2 point 이동

        self.layer.masksToBounds = false
    }
    
    func fadeIn(duration: TimeInterval = 1.0){
        UIView.animate(withDuration: duration) {
            self.alpha = 1.0
        }
    }
    
    func fadeOut(duration: TimeInterval = 1.0){
        UIView.animate(withDuration: duration) {
            self.alpha = .zero
        }
    }
  
}
