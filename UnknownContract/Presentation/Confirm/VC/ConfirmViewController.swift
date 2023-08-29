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

public class ConfirmViewController: UIViewController {
    
    
    let disposeBag = DisposeBag()
    
    lazy var cameraButton = UIButton().then{
        
        $0.setTitle("Camera", for: .normal)
        
    }
    
    lazy var uploadButton = UIButton().then{
        
        $0.setTitle("Upload", for: .normal)
    }
    
    lazy var resultLabel = UILabel().then{
        
        $0.numberOfLines = 0
        $0.textColor = .blue
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
        self.view.addSubview(cameraButton)
        self.view.addSubview(uploadButton)
        self.view.addSubview(resultLabel)
    }
    
    
    private func configureUI(){
        
     
        cameraButton.snp.makeConstraints{
            $0.top.equalTo(view.safeAreaLayoutGuide)
            
            $0.centerX.equalToSuperview()
    
        }
        
        uploadButton.snp.makeConstraints{
            
            $0.top.equalTo(cameraButton.snp.top)
            $0.centerX.equalTo(cameraButton.snp.right).offset(100)
            
        }
        
        resultLabel.snp.makeConstraints{
            
            $0.center.equalToSuperview()
        }
    }
    
    private func bind(){
        cameraButton.rx.tap
            .subscribe(onNext: { [weak self] in
                
                guard let self else {return}
                
                self.openCamera()
            })
            .disposed(by: disposeBag)
        
        
        uploadButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard let self else {return}
                self.openDoucument()
                
            })
            .disposed(by: disposeBag)
    }
    private func openDoucument(){
        let supportedTypes: [UTType] = [UTType.pdf]
        let pickerViewController = UIDocumentPickerViewController(forOpeningContentTypes: supportedTypes, asCopy: true)
        pickerViewController.delegate = self
        pickerViewController.allowsMultipleSelection = false
        pickerViewController.shouldShowFileExtensions = true
        self.present(pickerViewController, animated: true, completion: nil)
    }
    
    
    private func openCamera(){
        
        AVCaptureDevice.requestAccess(for: .video) { [weak self] isAuthorized in
       DEBUG_LOG(isAuthorized)
          guard isAuthorized else {
            self?.showAlertGoToSetting()
            return
          }
          
          DispatchQueue.main.async {
            let pickerController = UIImagePickerController() // must be used from main thread only
            pickerController.sourceType = .camera
            pickerController.allowsEditing = false
            pickerController.mediaTypes = ["public.image"]
            // 만약 비디오가 필요한 경우,
      //      imagePicker.mediaTypes = ["public.movie"]
      //      imagePicker.videoQuality = .typeHigh
            pickerController.delegate = self
            self?.present(pickerController, animated: true)
          }
        }
    }
    
    private func pdfToImage(path:String){
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
    
    func reconizeText(image:UIImage?) {
        guard let cgImage = image?.cgImage else {
            fatalError("could not get image")
        }
        
        
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest{ [weak self]request, error in
            
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            DEBUG_LOG(text)

            DispatchQueue.main.async {
                self?.resultLabel.text = text
            }
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
                print(possibleLanguages)
            } catch {
                print("Error getting the supported languages.")
            }
        } else {
            // Fallback on earlier versions
            request.recognitionLanguages =  ["ko-KR","en-US"]
            request.usesLanguageCorrection = true
        }
        
        do{
            try handler.perform([request])
        } catch {
            resultLabel.text = "\(error)"
            DEBUG_LOG(error)
        }
        
        
        
    }
    
    
    
    
}


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


extension ConfirmViewController:UIDocumentPickerDelegate{
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        guard let url = urls.first else {
            return
        }
        DEBUG_LOG(url.standardizedFileURL)
        pdfToImage(path: url.relativePath)
        
    }
}
