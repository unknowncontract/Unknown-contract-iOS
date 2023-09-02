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
    
    private lazy var scoreLabel = UILabel()
    
    private lazy var levelLabel = UILabel()
    
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
        
        
            let gradient = CAGradientLayer()
            gradient.colors = [dangerColor.cgColor,warningColor.cgColor,safeColor.cgColor]
            gradient.frame = outerStorkeView.bounds
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5) // 좌 센터에서
            gradient.endPoint = CGPoint(x: 1, y: 0.5) // 우 센터로
            gradient.type = .axial
            gradient.mask = trackLayer // 마스킹
            outerStorkeView.layer.addSublayer(gradient)
        
   
        
    }
    

}

private extension CircleDashBoardView {
    
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
        
        addProgressBar()
       

    }
    
    func scoreToProgress(_ score:Int) -> CGFloat {

        var offset:CGFloat = .zero
        switch score {
            
        case 0..<31:
            offset = -0.03
        
        case 31...50:
            offset = -0.01
            
        case 51..<70:
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
    
    func addProgressBar(){
        
        let fixedAngle:CGFloat = 12.78 * .pi / 180
        
        
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: 111, y: 111), radius: 111, startAngle: .pi - fixedAngle  , endAngle: fixedAngle  , clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.lightGray.cgColor // 색깔 안넣어주면 안보임
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor //
        trackLayer.lineCap = .square // 선 모양
        trackLayer.strokeEnd = 0
        
        // 30 % -> 0.3 - 0.03 = 0.27
        // 60 % -> 0.7 - 0.02 = 0.68
        

        //BarLayer
       shapeLayer.path = circularPath.cgPath
       shapeLayer.fillColor = UIColor.clear.cgColor
       shapeLayer.strokeColor = UIColor.clear.cgColor
       shapeLayer.lineWidth = 20
       shapeLayer.lineCap = .square
        
        
      outerStorkeView.layer.addSublayer(shapeLayer)


    }
    
}

public extension CircleDashBoardView {
    
    func loadProgress(_ score:Int){
            let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
    
            basicAnimation.toValue = scoreToProgress(score)
            basicAnimation.duration = 1
            basicAnimation.fillMode = .forwards
            basicAnimation.isRemovedOnCompletion = false

            var color:UIColor = .clear
            var message:String = ""
            switch score {
                
                case 0..<30:
                    color = dangerColor
                    message = "위험"
            
                case 30..<60:
                    color = warningColor
                    message = "주의"
                
                default:
            
                    message = "안전"
                    color = safeColor
                
                
            }
            
        
            scoreLabel.attributedText = setTitle1Style("\(score)점", textColor: color,alignment: .center)
            levelLabel.attributedText = setBody1Style(message,textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700,alignment: .center)
            trackLayer.add(basicAnimation, forKey: "progress")
    }
    
}


