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

    let dangerColor = colorFromRGB("F82C5F")
    let warningColor = colorFromRGB("FF8B25")
    let safeColor = colorFromRGB("25BDC5")

    private let trackLayer = CAShapeLayer()
    
    private let shapeLayer = CAShapeLayer()

    private lazy var outerStorkeView = UIView()
    
    private lazy var innerStrokeView = UIView().then{
        
        $0.layer.cornerRadius = 74
        
        $0.backgroundColor = .clear
        
        $0.layer.borderWidth = 1
        $0.layer.borderColor = DesignSystemAsset.AntarcticBlue.antarcticBlue200.cgColor
    }
    
    private lazy var scoreContainberView = UIView().then{
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 82
        $0.setShadow1()
    }
    
    private lazy var scoreLabel = UILabel().then{
        $0.attributedText = setTitle1Style("70점", textColor: safeColor,alignment: .center)
    }
    
    private lazy var levelLabel = UILabel().then{
        $0.attributedText = setBody1Style("안전", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700,alignment: .center)
    }
    
    private lazy var fixedLayerImageView = UIImageView().then{
        
        $0.contentMode = .scaleToFill
        $0.image = UIImage(named:"fixedLayer")
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
        addBorderCircularGradient(to:outerStorkeView,colors: [colorFromRGB("EFEFEF").cgColor,colorFromRGB("E0E0E0",alpha: 0.3062).cgColor,colorFromRGB("DBDBDB",alpha: 0.0001).cgColor], lineWidth: 1.25, startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        
        
       // loadProgress()
        
    }
    

}

public extension CircleDashBoardView {
    
    private func addSubViews(){
        addSubview(outerStorkeView)
        addSubview(scoreContainberView)
        scoreContainberView.addSubview(innerStrokeView)
        scoreContainberView.addSubview(scoreLabel)
        scoreContainberView.addSubview(levelLabel)
        addSubview(fixedLayerImageView)
        
        
    }
    
    
    private func setUp(){
        

        
        outerStorkeView.snp.makeConstraints{
            
            $0.centerX.bottom.equalToSuperview()
            $0.width.height.equalTo(222)
            $0.bottom.equalToSuperview()
        }
        
        scoreContainberView.snp.makeConstraints{
            $0.centerX.bottom.equalToSuperview()
            $0.width.height.equalTo(164)
            $0.bottom.equalToSuperview().inset(30)
        }
       
        innerStrokeView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalTo(148)
        }
        
        scoreLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        levelLabel.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(scoreLabel.snp.bottom)
        }
        
        fixedLayerImageView.snp.makeConstraints{
            
            $0.width.equalTo(283)
            $0.height.equalTo(147.48)
            $0.centerX.equalToSuperview().offset(5)
            $0.centerY.equalToSuperview().offset(-17)
        }
        
        addProgressBar(70)
        //scoreAnimation()
       

    }
    
    func scoreToProgress(_ score:Int) -> CGFloat {

        var offset:CGFloat = .zero
        switch score {
            
        case 0..<31:
            offset = -0.03
        
        case 31..<70:
            offset = 0.08
            
        
        case 70..<90:
            offset = 0.05
        
        case 90..<101:
            offset = 0.03
            
        
        default:
            offset = .zero
            
        }
        
        var cgScore = CGFloat(score) / 100

        return cgScore + offset


    }
    
    func addProgressBar(_ score:Int){
        
        let fixedAngle:CGFloat = 12.78 * .pi / 180
        
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 111, y: 111), radius: 111, startAngle: .pi - fixedAngle  , endAngle: fixedAngle  , clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.red.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor //
        trackLayer.lineCap = .square // 선 모양
        trackLayer.strokeEnd = scoreToProgress(score)
        
        // 30 % -> 0.3 - 0.03 = 0.27
        // 60 % -> 0.7 - 0.02 = 0.68
        

        //BarLayer
       shapeLayer.path = circularPath.cgPath
       shapeLayer.fillColor = UIColor.clear.cgColor
       shapeLayer.strokeColor = UIColor.systemGreen.cgColor
       shapeLayer.lineWidth = 20
       shapeLayer.lineCap = .square
        
        
        outerStorkeView.layer.addSublayer(shapeLayer)
        
        outerStorkeView.layer.addSublayer(trackLayer)
        
        //addGradient()
        
  
        

    }
    
    
    private func addGradient() {
        
        let gradient = CAGradientLayer()
            gradient.colors = [UIColor.red.cgColor,UIColor.cyan.cgColor,UIColor.brown.cgColor,UIColor.blue.cgColor]
            gradient.frame = bounds
            gradient.locations = [0.2,0.5,0.75,1]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
            gradient.endPoint = CGPoint(x: 0.5, y: 0)
            gradient.type = .conic
            gradient.mask = shapeLayer
            outerStorkeView.layer.addSublayer(gradient)
    }

    func loadProgress(){
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
            basicAnimation.toValue = 1
            basicAnimation.duration = 2
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false
    
    
    
            trackLayer.add(basicAnimation, forKey: "progress")
    }
    
    func scoreAnimation(){
       
        
        let fixedAngle:CGFloat = 12.78 * .pi / 180
        
        
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 111, y: 111), radius: 111, startAngle: .pi - fixedAngle  , endAngle: fixedAngle  , clockwise: true)
       
        
        
    
        trackLayer.path = circlePath.cgPath
        trackLayer.strokeColor = dangerColor.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor //
        trackLayer.lineCap = .square // 선 모양
        
        trackLayer.strokeEnd = 0
        outerStorkeView.layer.addSublayer(trackLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false

        
        
        trackLayer.add(basicAnimation, forKey: "progress")
       
        

        

    }
    
}


