//
//  GradientThinStrokeCircleView.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/09/01.
//

import UIKit
import SnapKit
import Then


// EFEFEF
// E0E0E0
// DBDBDB

public class GradientThinStrokeCircleView: UIView {
    
    lazy var view = UIView()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
        self.addSubview(view)

        view.snp.makeConstraints{
            $0.width.height.equalTo(222)
        }
    }
    
    required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
//    public override func draw(_ rect: CGRect) {
//
//
//    }
}

extension GradientThinStrokeCircleView {
    
    func setBorder(){
        self.layer.cornerRadius = self.bounds.size.height / 2.0
        self.clipsToBounds = true
        
        //Create object of CAGradientLayer
        let gradient = CAGradientLayer()
        //Assign origin and size of gradient so that it will fit exactly over circular view
        gradient.frame = self.bounds
        
        let color1 = colorFromRGB("EFEFEF")
        let color2 = colorFromRGB("E0E0E0",alpha: 0.3062)
        let color3 = colorFromRGB("DBDBDB",alpha: 0.001)

        
        gradient.colors = [color1.cgColor, color2.cgColor,color3.cgColor]
        
        
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        //Point where gradient should end
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        
        //view’s layer
        let shape = CAShapeLayer()
        //Width of circular line
        shape.lineWidth = 10
        //Create circle with center same as of center of view, with radius equal to half height of view, startAngle is the angle from where circle should start, endAngle is the angle where circular path should end
        shape.path = UIBezierPath(
        arcCenter: CGPoint(x: self.bounds.height/2,
        y: self.bounds.height/2),
        radius: self.bounds.height/2,
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
        self.layer.addSublayer(gradient)

    }
}
