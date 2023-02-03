//
//  QRScanerView.swift
//  Halol&Harom
//
//  Created by Mekhriddin Jumaev on 27/01/23.
//

import Foundation
import AVFoundation
import UIKit
import Vision


class QRScanerViewController: BaseViewController, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var parseCodeDidFinished: ((_ code: String) -> Void)?
    var centerView = QRScannerCenterView()
    
    lazy var scannerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        navigationItem.hidesBackButton = true
        return v
    }()
    
    lazy var closeButton: UIButton = {
        let b = UIButton()
        b.setTitle("", for: .normal)
        b.setImage(UIImage.init(named: "CloseButton"), for: .normal)
        b.addTarget(self, action: #selector(closeButtontapped), for: .touchUpInside)
        return b
    }()
    
    lazy var topTitleLabel: UILabel = {
        let l = UILabel()
        l.attributedText = NSAttributedString.getAttrTextWith(17, "Strix kodini kvadratga kiriting", false, .white, .center)
        return l
    }()
    
    private func setupView() {
        view.addSubview(scannerView)
        view.addSubview(centerView)
        view.addSubview(closeButton)
        view.addSubview(topTitleLabel)
        scannerView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        centerView.anchor(top: nil, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: self.view.frame.width * 0.6, height: self.view.frame.width * 0.6))
        centerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        centerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topTitleLabel.anchor(top: centerView.bottomAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 120, left: 20, bottom: 0, right: 20))
        topTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 0), size: CGSize(width: 30, height: 30))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationItem.hidesBackButton = false
        centerView.backgroundColor = .clear
        self.navigationItem.titleView = twoLineTitleView(text: "Shtrix kod skanner", color: UIColor.white)
        imagePicker.delegate = self
        let flashBarButton = UIBarButtonItem(image: UIImage(systemName: "bolt.fill")!, style: .plain, target: self, action: #selector(flashLightButtonTapped))
        let galaryBarButton = UIBarButtonItem(image: UIImage(systemName: "photo.on.rectangle.angled")!, style: .plain, target: self, action: #selector(flashTapped))
        flashBarButton.tintColor = .white
        galaryBarButton.tintColor = .white
        navigationItem.rightBarButtonItem = flashBarButton
        navigationItem.leftBarButtonItem = galaryBarButton
        view.backgroundColor = UIColor.init(hex: "#050505")
        scannerView.backgroundColor = UIColor.init(hex: "#050505")
        scannerView.clipsToBounds = true
        captureSession = AVCaptureSession()
        setupView()
      
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            print(error.localizedDescription)
            return
        }
        
        if captureSession.canAddInput( videoInput ) {
            captureSession.addInput(videoInput)
        } else {
            captureSession = nil
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        if captureSession.canAddOutput(metadataOutput) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
        } else { return }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        previewLayer.frame = scannerView.bounds
        runScan()
    }
    
    @objc private func flashTapped() {
        //Utils.toggleFlash()
    }
    
    func runScan() {
        DispatchQueue.main.async {
            if self.captureSession?.isRunning == false {
                self.captureSession.startRunning()
            }
        }
    }
    @objc func flashLightButtonTapped(_ sender: Any) {
        Utils.toggleFlash()
    }
    
    @objc func closeButtontapped(_ sender: Any) {
        self.back(with: .pop)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard previewLayer != nil else { return }
        previewLayer.frame = scannerView.bounds
        scannerView.layer.insertSublayer(previewLayer, at: 0)
        runScan()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async {
            if self.captureSession?.isRunning == true {
                self.captureSession.stopRunning()
            }
        }
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer?.frame = scannerView.bounds
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            parseCodeDidFinished?(stringValue)
            print("Code is", stringValue)
            navigationController?.pushViewController(ResultViewController(code: stringValue), animated: true)
            self.captureSession.stopRunning()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    var imagePicker = UIImagePickerController()
    
    @objc private func imageTapped() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
}


extension QRScanerViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        
        guard let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Error!")
        }
        
        createVisionRequest(image: uiImage)
    }
}

enum DetectionTypes {
    case Barcode
}

extension QRScanerViewController
{
    func createVisionRequest(image: UIImage)
    {
        guard let cgImage = image.cgImage else {
            return
        }
        let requestHandler = VNImageRequestHandler(cgImage: cgImage)
        let vnRequests = [vnBarCodeDetectionRequest]
        DispatchQueue.global(qos: .background).async {
            do{
                try requestHandler.perform(vnRequests)
            }catch let error as NSError {
                print("Error in performing Image request: \(error)")
            }
        }
        
    }
    
    var vnBarCodeDetectionRequest : VNDetectBarcodesRequest{
        let request = VNDetectBarcodesRequest { (request,error) in
            if let error = error as NSError? {
                print("Error in detecting - \(error)")
                return
            }
            else {
                guard let observations = request.results as? [VNBarcodeObservation]
                    else {
                        return
                }
                if let payload = observations[0].payloadStringValue {
                    print("Code is \(payload)")
                    self.navigationController?.pushViewController(ResultViewController(code: payload), animated: true)
                }
            }
        }
        
        return request
    }
}
