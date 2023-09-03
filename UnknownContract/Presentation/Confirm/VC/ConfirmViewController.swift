//
//  ConfirmViewController.swift
//  UnknownContract
//
//  Created by yongbeomkwak on 2023/08/29.
//

import UIKit
import SnapKit
import Then
import AVFoundation
import VisionKit
import Vision
import RxCocoa
import RxSwift
import PDFKit
import Lottie

public final class ConfirmViewController: BaseViewController {
    
    
    let disposeBag = DisposeBag()
    
    
    private var viewModel:ConfirmViewModel!
    private var customCameraComponent:CustomCameraComponent!
    
    
    lazy var input = ConfirmViewModel.Input()
    
    lazy var output = viewModel.transform(input: input)
    
    
    lazy var navigationBarView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var backButton = UIButton().then{
        
        $0.setImage(DesignSystemAsset.Icon.arrowLeft, for: .normal)
    }
    
    lazy var navigationTitleLabel = UILabel().then{
        $0.attributedText = setBody1Style(viewModel.document.checkNavigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
    }
    
    lazy var baseLine = UILabel().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
    lazy var titleLabel = UILabel().then{
        $0.attributedText = setTitle2Style("검토사항", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000,alignment: .center)
    }
    
    lazy var descriptionLabel = UILabel().then{
        $0.numberOfLines = 0
        $0.attributedText = setBody2Style("계약서에 명시된 특약사항 중 임차인에게\n불리한 내용이 있는지 검토합니다.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue700,alignment: .center)
    }
    
    lazy var cameraFunctionButtonView = FunctionView(function: .camera).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.delegate = self
    }
    lazy var uploadFunctionButtonView = FunctionView(function: .upload).then{
        $0.layer.cornerRadius = 10
        $0.backgroundColor = .white
        $0.delegate = self
    }
    
    lazy var loadingView = UIView().then{
        $0.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    lazy var lottieView = LottieAnimationView(name: "Loading").then{
        $0.backgroundColor = .clear
        $0.contentMode = .scaleAspectFill
        $0.loopMode = .loop
    }
    
    lazy var confirmLabel = UILabel().then{
        $0.attributedText = setTitle2Style("정보를 확인중입니다.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100,alignment: .center)
    }
    
    lazy var askWaitingLabel = UILabel().then{
        $0.attributedText = setBody1Style("잠시만 기다려주세요.", textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue100,alignment: .center)
    }
    
    lazy var imageView = UIImageView().then{
        $0.contentMode = .scaleAspectFill
    }
    
    init(customCameraComponent:CustomCameraComponent,viewModel:ConfirmViewModel){
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
        self.customCameraComponent = customCameraComponent
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
        configureUI()
        bind()
    }
    
    public override func viewDidAppear(_ animated: Bool) { // Swipe Navigation Back
           super.viewDidAppear(animated)
           navigationController?.interactivePopGestureRecognizer?.delegate = nil
       }
    

}

extension ConfirmViewController {
    private func addSubViews(){
        
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
    
        self.view.addSubview(titleLabel)
        self.view.addSubview(descriptionLabel)
        
        self.view.addSubview(cameraFunctionButtonView)
        self.view.addSubview(uploadFunctionButtonView)
        
        self.view.addSubview(loadingView)
        
        self.loadingView.addSubview(lottieView)
        self.loadingView.addSubview(confirmLabel)
        self.loadingView.addSubview(askWaitingLabel)
        
        self.view.addSubview(imageView)
    }
    
    
    private func configureUI(){
    
        navigationBarView.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
            $0.left.right.equalToSuperview()
        }
        
        backButton.snp.makeConstraints{
            $0.width.height.equalTo(32)
            $0.left.equalToSuperview().inset(MARGIN())
            $0.centerY.equalToSuperview()
        }
        
        navigationTitleLabel.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
        
        baseLine.snp.makeConstraints{
            
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(navigationBarView.snp.bottom).offset(32)
            $0.left.right.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.left.right.equalToSuperview().inset(20)
        }
        
        cameraFunctionButtonView.snp.makeConstraints{
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(60)
            $0.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.top.equalTo(cameraFunctionButtonView.button)
            
            $0.bottom.left.right.equalToSuperview()
            
        }
        
        uploadFunctionButtonView.snp.makeConstraints{
            $0.top.equalTo(cameraFunctionButtonView.snp.bottom).offset(24)
            $0.centerX.equalToSuperview()
        }
        
        loadingView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        lottieView.snp.makeConstraints{
            
           let orgiMargin: CGFloat =  330.0
           let originHeight: CGFloat = 812.0
           let rate: CGFloat = orgiMargin / originHeight

           let height: CGFloat = APP_HEIGHT() * rate
            
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(height)
            $0.width.equalTo(54)
            $0.height.equalTo(14)
        }
        
        confirmLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(lottieView.snp.bottom).offset(32)
        }
        
        askWaitingLabel.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalTo(confirmLabel.snp.bottom).offset(8)
        }
        
        loadingView.isHidden = true
           
    }
    
    private func bind(){
        backButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                owner.navigationController?.popViewController(animated: true)
                
            })
            .disposed(by: disposeBag)
        
        
        output.answerText
            .subscribe { [weak self] message in
                
                guard let self else {return}
                
                self.stopLottie(result: message)
                DEBUG_LOG(message)
            }
            .disposed(by: disposeBag)
        
        output.startLottie
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                self.playLottie()
                
                
            })
            .disposed(by: disposeBag)
        
        output.showToast
            .withUnretained(self)
            .subscribe(onNext: { (owner,_) in
                
                owner.lottieView.stop()
                owner.loadingView.isHidden = true
                owner.showToast(text: "다시시도", font: DesignSystemAsset.Pretendard.body3)
                
        })
        .disposed(by: disposeBag)
    }
    
    private func playLottie(){
        lottieView.frame = self.view.frame
        loadingView.isHidden = false
        
      

        lottieView.play()
    }
    
    private func stopLottie(result:BaseMessage){
        
        lottieView.stop()
        loadingView.isHidden = true
        
    
        NotificationCenter.default.post(name: .gptAnswer, object: result) // 결과 보내기 -> 홈으로
        
            
    }
    
    // 실질적인 동장
    
    
    private func openDoucument(){
        let supportedTypes: [UTType] = [UTType.pdf]
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        pickerViewController.delegate = self
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.shouldShowFileExtensions = true
        self.present(pickerViewController, animated: true, completion: nil)
    }
    
    
    /// 카메라 열기
    private func openCamera(){
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
          guard isAuthorized else { // 허가되지 않으면 얼럿 호출
            self?.showAlertGoToSetting()
            return
          }
          
          DispatchQueue.main.async {
            let pickerController = UIImagePickerController() // must be used from main thread only
            pickerController.sourceType = .camera
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]

            pickerController.delegate = self
            self?.present(pickerController, animated: true)
          }
        }
    }
    
//    private func pdfToImage(path:String){
//
//            //TODO: 여러 장 추출
//
//            // Create a URL for the PDF file.
//            let url = URL(fileURLWithPath: path)
//
//            // Instantiate a `CGPDFDocument` from the PDF file's URL.
//            guard let document = PDFDocument(url: url) else { return }
//
//            // Get the first page of the PDF document.
//            guard let page = document.page(at: 0) else { return }
//
//            // Fetch the page rect for the page we want to render.
//            let pageRect = page.bounds(for: .mediaBox)
//
//            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
//            let img = renderer.image { ctx in
//                // Set and fill the background color.
//                UIColor.white.set()
//                ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))
//
//                // Translate the context so that we only draw the `cropRect`.
//                ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)
//
//                // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
//                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
//
//                // Draw the PDF page.
//                page.draw(with: .mediaBox, to: ctx.cgContext)
//            }
//
//            reconizeText(image: img)
//        }
    
    private func pdfToImage(path:String){


        let url = URL(fileURLWithPath: path)

        // Instantiate a `CGPDFDocument` from the PDF file's URL.
        guard let document = PDFDocument(url: url) else { return }

        var width:CGFloat = .zero
        var height:CGFloat = .zero
        
        if document.pageCount == 1 || viewModel.document == .building { // 단일 PDF 또는 건축물 대장
            
            guard let page = document.page(at: 0) else { return }
            // Fetch the page rect for the page we want to render.
            let pageRect = page.bounds(for: .mediaBox)

            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
            let img = renderer.image { ctx in
                // Set and fill the background color.
                UIColor.white.set()
                ctx.fill(CGRect(x: 0, y: 0, width: pageRect.width, height: pageRect.height))

                // Translate the context so that we only draw the `cropRect`.
                ctx.cgContext.translateBy(x: -pageRect.origin.x, y: pageRect.size.height - pageRect.origin.y)

                // Flip the context vertically because the Core Graphics coordinate system starts from the bottom.
                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

                // Draw the PDF page.
                page.draw(with: .mediaBox, to: ctx.cgContext)
            }

            reconizeText(image: img)
            
            return
            
        }
        
        // 다중 PDF

        for i in 0..<document.pageCount{

            if let page = document.page(at: i) {
                let pageRect = page.bounds(for: .mediaBox)
                width = max(width,pageRect.width)
                height += pageRect.height
            }

        }



        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
        let img = renderer.image { ctx in
            // Set and fill the background color.
            UIColor.white.set()
            ctx.fill(CGRect(x: 0, y: 0, width: width, height: height))

            // Translate the context so that we only draw the `cropRect`.

            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            for index in 0...document.pageCount {

                if let page = document.page(at: index) {
                    let pageRect = page.bounds(for: .mediaBox)
            
                    ctx.cgContext.translateBy(x: -pageRect.origin.x, y: -pageRect.height)

                    page.draw(with: .mediaBox, to: ctx.cgContext)
                }
            }


        }


        reconizeText(image: img)
    }
    
    func showAlertGoToSetting() {
      let alertController = UIAlertController(
        title: "현재 카메라 사용에 대한 접근 권한이 없습니다.",
        message: "설정 > {모르는계약}탭에서 접근을 활성화 할 수 있습니다.",
        preferredStyle: .alert
      )
      let cancelAlert = UIAlertAction(
        title: "취소",
        style: .cancel
      ) { _ in
          alertController.dismiss(animated: true, completion: nil)
        }
      let goToSettingAlert = UIAlertAction(
        title: "설정으로 이동하기",
        style: .default) { _ in
          guard
            let settingURL = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingURL)
          else { return }
          UIApplication.shared.open(settingURL, options: [:])
        }
      [cancelAlert, goToSettingAlert]
        .forEach(alertController.addAction(_:))
      DispatchQueue.main.async {
        self.present(alertController, animated: true) // must be used from main thread only
      }
    }
    
    
    ///OCR
    func reconizeText(image:UIImage?) {
        self.output.startLottie.accept(())
        
        
        guard let cgImage = image?.cgImage else {
            fatalError("could not get image")
        }
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest{ [weak self]request, error in
            
            guard let self else {return}
            
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{
               
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            DEBUG_LOG(text)
            self.input.resultText.accept(text) // 최종 OCR 결과
        }
        
        if #available(iOS 16.0, *) {
            let revision3 = VNRecognizeTextRequestRevision3
            request.revision = revision3
            request.recognitionLevel = .accurate
            request.recognitionLanguages =  ["ko-KR","en-US"]
            request.usesLanguageCorrection = true
            
            do {
                var possibleLanguages: Array<String> = []
                possibleLanguages = try request.supportedRecognitionLanguages()
            } catch {
                DEBUG_LOG("Error getting the supported languages.")
            }
        } else {
            // Fallback on earlier versions
            request.recognitionLanguages =  ["ko-KR","en-US"]
            request.usesLanguageCorrection = true
        }
        
        do{
            try handler.perform([request])
        } catch {
            DEBUG_LOG(error)
        }
        
        
        
    }
    
    
    
    
}


extension ConfirmViewController:FunctionViewViewDelegate {
    public func action(function: Function) {
        
        switch function{
            
        case .camera:
            
            let vc = customCameraComponent.makeView(doucment: viewModel.document)
            
            vc.modalPresentationStyle =  .fullScreen
            vc.delegate = self
            
            self.present(vc, animated: true)
            
        case .upload:
            openDoucument()
        }
    }
    
    
}


/// 카메라를 이용한 OCR
extension ConfirmViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
          picker.dismiss(animated: true)
          return
        }
        

        reconizeText(image: image)
        
        
        picker.dismiss(animated: true,completion: nil)
    }
}

extension ConfirmViewController : CustomCameraDelegate {
    public func action(image: UIImage?) {
            reconizeText(image: image)
    }
    
}


/// 업로드를 이용한 OCR
extension ConfirmViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let url = urls.first else {
            return
        }
        pdfToImage(path: url.relativePath)
        
    }
}
