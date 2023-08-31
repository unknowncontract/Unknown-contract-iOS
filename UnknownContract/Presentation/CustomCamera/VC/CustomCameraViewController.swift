//
//  CustomCameraViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/30.
//

import UIKit
import SnapKit
import Then
import AVFoundation
import RxSwift
import RxCocoa

public class CustomCameraViewController: BaseViewController {
    
    let bgColor = UIColor.black.withAlphaComponent(0.6)
    
    let disposeBag = DisposeBag()
    
    var captureSession:AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice:AVCaptureDevice!
    
    lazy var statusEmptyView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    lazy var titleView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setBody1Style("임대차계약서 촬영", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100)
    }
    
    lazy var closeButton = UIButton().then{
        
        
        $0.setImage(DesignSystemAsset.Icon.whiteClose, for: .normal)
    }
    
    
    lazy var bottomView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    lazy var warningLabel = UILabel().then{
        $0.attributedText = setBody2Style("어두운 배경에서 빛이 반사되지 않도록 촬영해주세요.\n훼손 시 확인이 어려울 수 있습니다.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100)
        
        $0.numberOfLines = 0 
        $0.textAlignment = .center
    }
    
    lazy var shutterButton = UIButton().then{
        $0.setImage(DesignSystemAsset.Icon.shutter, for: .normal)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        prepareaCamera()
        addSubViews()
        configureUI()
        
        bind()
        
        
    }
    public override var preferredStatusBarStyle: UIStatusBarStyle { //DARK MODE
        return  .lightContent
    }
}


extension CustomCameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
}

extension CustomCameraViewController{
    
    func prepareaCamera(){
        
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            
            DEBUG_LOG("WOW")
            
            return
        }
        
        captureDevice = backCamera
        beginSession()
      
        
    }
    
    func beginSession() {
        
        do{
            
            let captureDeviceInput = try AVCaptureDeviceInput(device: captureDevice)
            
            photoOutput = AVCapturePhotoOutput()
            captureSession.addInput(captureDeviceInput)
            captureSession.sessionPreset = .photo
            captureSession.addOutput(photoOutput)
            captureSession.commitConfiguration()
        } catch {
            DEBUG_LOG(error.localizedDescription)
        }

        
        self.previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        DispatchQueue.main.async {
            
            self.previewLayer.frame = self.view.layer.frame
            
        }
        
        previewLayer?.videoGravity = .resizeAspectFill
        self.view.layer.addSublayer(self.previewLayer)
       
        
        
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
        

    }
    
    
    private func addSubViews(){
        
        self.view.addSubview(statusEmptyView)
        self.view.addSubview(titleView)
        self.view.addSubview(bottomView)
        
        self.titleView.addSubview(titleLabel)
        self.titleView.addSubview(closeButton)
        
        self.bottomView.addSubview(warningLabel)
        self.bottomView.addSubview(shutterButton)
    }
    
    
    private func configureUI(){
        
        statusEmptyView.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
            $0.height.equalTo(STATUS_BAR_HEGHIT())
        }
        
        titleView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(statusEmptyView.snp.bottom)
            $0.height.equalTo(48)
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.right.equalToSuperview().inset(MARGIN())
        }
        
        bottomView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            
            $0.height.equalTo(200)
        }
        
        warningLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(24)
            $0.centerX.equalToSuperview()
        }
        
        shutterButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func bind(){
        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
    }
}
