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


public protocol CustomCameraDelegate : NSObject {
    func action(image:UIImage?)
}


public class CustomCameraViewController: BaseViewController {
    
    let bgColor = UIColor.black.withAlphaComponent(0.8)
    
    let disposeBag = DisposeBag()
    
    var doucment:Document!
    var captureSession:AVCaptureSession!
    var photoOutput: AVCapturePhotoOutput!
    var previewLayer:AVCaptureVideoPreviewLayer!
    var captureDevice:AVCaptureDevice!
    var photoSettings: AVCapturePhotoSettings!
    
    
    
    weak var delegate : CustomCameraDelegate?
    
    lazy var statusEmptyView = UIView().then{
        $0.backgroundColor = bgColor
    }
    
    lazy var titleView = UIView().then{
        $0.backgroundColor = bgColor
    }
   
    lazy var titleLabel = UILabel()
    
    lazy var closeButton = UIButton().then{
        
        
        $0.setImage(DesignSystemAsset.Icon.whiteClose, for: .normal)
    }
    
    
    lazy var bottomView = UIView().then{
        $0.backgroundColor = bgColor
    }
    

    
    lazy var shutterButton = UIButton().then{
        $0.setImage(DesignSystemAsset.Icon.shutter, for: .normal)
    }
   
    init(doucment:Document){
        super.init(nibName: nil, bundle: nil)
        self.doucment = doucment
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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


extension CustomCameraViewController: AVCapturePhotoCaptureDelegate {
    
    public func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation() else { return}
        
        let image = UIImage(data: imageData)
        
        
        delegate?.action(image: image)
        dismiss(animated: true)
        
    }
}

extension CustomCameraViewController{
    
    func prepareaCamera(){
        
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
        
        
        guard let backCamera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            

            
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
            
            if photoOutput.availablePhotoCodecTypes.contains(.hevc) {
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])
              } else{
                photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
              }
            
            
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
            $0.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        titleLabel.attributedText = setBody1Style(doucment.cameraNavigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100)
        
        closeButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(32)
            $0.right.equalToSuperview().inset(MARGIN())
        }
        
        bottomView.snp.makeConstraints{
            $0.left.right.bottom.equalToSuperview()
            
            $0.height.equalTo(172)
        }
        

        
        shutterButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(64)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
        }
    }
    
    private func bind(){
        
        closeButton.rx.tap
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                self.dismiss(animated: true)
            })
            .disposed(by: disposeBag)
        
        shutterButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else {return}
                
                self.photoOutput.capturePhoto(with: self.photoSettings, delegate: self)
                
            })
            .disposed(by: disposeBag)
        
    }
}
