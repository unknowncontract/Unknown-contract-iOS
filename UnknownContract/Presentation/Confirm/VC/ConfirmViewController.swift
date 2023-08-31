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

public final class ConfirmViewController: BaseViewController {
    
    
    let disposeBag = DisposeBag()
    
    
    private var viewModel:ConfirmViewModel!
    
    
    
    lazy var input = ConfirmViewModel.Input()
    
    lazy var output = viewModel.transform(input: input)
    
    
    lazy var navigationBarView = UIView().then{
        $0.backgroundColor = .clear
    }
    
    lazy var backButton = UIButton().then{
        
        $0.setImage(DesignSystemAsset.Icon.arrowLeft, for: .normal)
    }
    
    lazy var navigationTitleLabel = UILabel().then{
        $0.attributedText = setBody1Style(viewModel.document.navigationTitle, textColor: DesignSystemAsset.AntarcticBlue.antarcticBlue1000)
    }
    
    lazy var baseLine = UILabel().then{
        $0.backgroundColor = DesignSystemAsset.AntarcticBlue.antarcticBlue300
    }
    
    
    
    init(viewModel:ConfirmViewModel){
        self.viewModel = viewModel
        
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        addSubViews()
        configureUI()
        bind()
    }
    

}

extension ConfirmViewController {
    private func addSubViews(){
        
        self.view.addSubview(navigationBarView)
        self.navigationBarView.addSubview(backButton)
        self.navigationBarView.addSubview(navigationTitleLabel)
        self.navigationBarView.addSubview(baseLine)
    
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

        

    }
    
    private func bind(){

    }
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
    
    private func pdfToImage(path:String){
        
        //TODO: 여러 장 추출 
        
        // Create a URL for the PDF file.
        let url = URL(fileURLWithPath: path)

        // Instantiate a `CGPDFDocument` from the PDF file's URL.
        guard let document = PDFDocument(url: url) else { return }

        // Get the first page of the PDF document.
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


/// 업로드를 이용한 OCR
extension ConfirmViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let url = urls.first else {
            return
        }
        pdfToImage(path: url.relativePath)
        
    }
}
