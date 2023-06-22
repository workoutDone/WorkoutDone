//
//  HomeButtonCameraViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/17.
//

import UIKit
import SnapKit
import Then
import AVFoundation

final class HomeButtonCameraViewController : BaseViewController {
    
    private var backCameraOn: Bool = true
    
    private var takePicture = false
    private let captureSettion = AVCaptureSession()
    private var videoDeviceInput : AVCaptureDeviceInput!
    private let photoOutput = AVCapturePhotoOutput()
    private var isBack : Bool = true
    private let captureDevice = AVCaptureDevice.default(for: .video)
    private let sesstionQueue = DispatchQueue(label: "sesstion Queue")
    private let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    private let deniedCameraView = PermissionDeniedView(permissionTitle: "카메라")
    private let authorizedCameraView = HomeButtonAuthorizedCameraView()
    private let gridToggleButton = GridToggleButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuth()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        authorizedCameraView.shutterButton.isEnabled = true
    }

    
    override func setComponents() {
        super.setComponents()
        
        view.backgroundColor = .colorFFFFFF
        deniedCameraView.isHidden = true
        authorizedCameraView.isHidden = true
        let barButton = UIBarButtonItem()
        barButton.customView = gridToggleButton
        navigationItem.rightBarButtonItem = barButton
        navigationController?.isNavigationBarHidden = false
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchCamera))
        authorizedCameraView.previewView.addGestureRecognizer(pinchRecognizer)
    }
    
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(deniedCameraView, authorizedCameraView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        authorizedCameraView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        deniedCameraView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func actions() {
        deniedCameraView.permisstionButton.addTarget(self, action: #selector(permisstionButtonTapped), for: .touchUpInside)
        authorizedCameraView.shutterButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        authorizedCameraView.switchCameraButton.addTarget(self, action: #selector(switchCameraButtonTapped), for: .touchUpInside)
        
        gridToggleButton.addTarget(self, action: #selector(gridToggleButtonTapped), for: .touchUpInside)
    }
    
    @objc func permisstionButtonTapped() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    
    @objc func gridToggleButtonTapped(sender: UIButton!) {
        if gridToggleButton.isOnToggle {
            authorizedCameraView.gridImageView.isHidden = true
            
        } else {
            authorizedCameraView.gridImageView.isHidden = false
        }
        gridToggleButton.changeToggle()
        gridToggleButton.isOnToggle = !gridToggleButton.isOnToggle
    }

    @objc func captureButtonTapped() {
        let videoPreviewLayerOrientaion = self.authorizedCameraView.previewView.previewLayer.connection?.videoOrientation
        sesstionQueue.async {
            let connection = self.photoOutput.connection(with: .video)
            connection?.videoOrientation = videoPreviewLayerOrientaion!
            let setting = AVCapturePhotoSettings()
            self.photoOutput.capturePhoto(with: setting, delegate: self)
        }
        authorizedCameraView.shutterButton.isEnabled = false
    }
    
    @objc func switchCameraButtonTapped(sender: UIButton!) {
        guard videoDeviceDiscoverySession.devices.count > 1 else {
            return
        }
        
        sesstionQueue.async {
            let currentVideoDevice = self.videoDeviceInput.device
            let currentPosition = currentVideoDevice.position
            self.isBack = currentPosition == .front
            let preferredPosition : AVCaptureDevice.Position = self.isBack ? .back : .front
            let devices = self.videoDeviceDiscoverySession.devices
            var newVideoDevice : AVCaptureDevice?
            
            newVideoDevice = devices.first(where: { device in
                return preferredPosition == device.position
            })
            
            if let newDevice = newVideoDevice {
                do {
                    let videoDeviceInput = try AVCaptureDeviceInput(device: newDevice)
                    self.captureSettion.beginConfiguration()
                    self.captureSettion.removeInput(self.videoDeviceInput)
                    
                    if self.captureSettion.canAddInput(videoDeviceInput) {
                        self.captureSettion.addInput(videoDeviceInput)
                        self.videoDeviceInput = videoDeviceInput
                    } else {
                        self.captureSettion.addInput(self.videoDeviceInput)
                    }
                    self.captureSettion.commitConfiguration()
                    
                    DispatchQueue.main.async {
                        self.authorizedCameraView.previewView.session = self.captureSettion
                        print("?????????????")
                    }
                    
                } catch let error  {
                    print("error occured while creating device input : \(error.localizedDescription)")
                }
            }
        }
    }
    @objc
        func handlePinchCamera(_ pinch: UIPinchGestureRecognizer) {
            guard let device = captureDevice else {return}
            
            var initialScale: CGFloat = device.videoZoomFactor
            let minAvailableZoomScale = 1.0
            let maxAvailableZoomScale = device.maxAvailableVideoZoomFactor
            
            do {
                try device.lockForConfiguration()
                if(pinch.state == UIPinchGestureRecognizer.State.began){
                    initialScale = device.videoZoomFactor
                }
                else {
                    if(initialScale*(pinch.scale) < minAvailableZoomScale){
                        device.videoZoomFactor = minAvailableZoomScale
                    }
                    else if(initialScale*(pinch.scale) > maxAvailableZoomScale){
                        device.videoZoomFactor = maxAvailableZoomScale
                    }
                    else {
                        device.videoZoomFactor = initialScale * (pinch.scale)
                    }
                }
                pinch.scale = 1.0
            } catch {
                return
            }
            device.unlockForConfiguration()
        }
    private func requestAuth() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self = self else { return }
            if granted {
                self.requestAuthResponseView(granted: true) { _ in
                    DispatchQueue.main.async {
                        self.deniedCameraView.isHidden = true
                        self.authorizedCameraView.isHidden = false
                        self.authorizedCameraView.previewView.session = self.captureSettion
                        print(self.authorizedCameraView.isHidden, "dd")
                    }
                    self.sesstionQueue.async {
                        self.setupSession()
                        self.startSession()
                    }
                }
            }
            else {
                self.requestAuthResponseView(granted: false) { _ in
                    DispatchQueue.main.async {
                        self.deniedCameraView.isHidden = false
                        self.authorizedCameraView.isHidden = true
                    }
                }
            }
        }
    }

    private func requestAuthResponseView(granted: Bool, completion : @escaping ((Bool) -> Void)) {
        if granted {
            completion(true)
        }
        else {
            completion(false)
        }
    }


}

extension HomeButtonCameraViewController {
    func setupSession() {
        captureSettion.sessionPreset = .photo
        captureSettion.beginConfiguration()
        
        guard let camera = videoDeviceDiscoverySession.devices.first else {
            captureSettion.commitConfiguration()
            return
        }
        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: camera)
            
            if captureSettion.canAddInput(videoDeviceInput) {
                captureSettion.addInput(videoDeviceInput)
                self.videoDeviceInput = videoDeviceInput
            } else {
                captureSettion.commitConfiguration()
                return
            }
        } catch _ {
            captureSettion.commitConfiguration()
            return
        }
        
        photoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        if captureSettion.canAddOutput(photoOutput) {
            captureSettion.addOutput(photoOutput)
        } else {
            captureSettion.commitConfiguration()
            return
        }
        captureSettion.commitConfiguration()
    }
    
    func startSession() {
        sesstionQueue.async {
            if !self.captureSettion.isRunning {
                self.captureSettion.startRunning()
            }
        }
    }
    
    func stopSession() {
        sesstionQueue.async {
            if self.captureSettion.isRunning {
                self.captureSettion.stopRunning()
            }
        }
    }
}

extension HomeButtonCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard error == nil else { return }
        guard let imageData = photo.fileDataRepresentation() else { return }
        guard let image = UIImage(data: imageData) else { return }
        let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
       
        DispatchQueue.main.async {
            let pressShutterVC = PressShutterViewController()
            pressShutterVC.captureImage = self.isBack ? image : flippedImage
            pressShutterVC.isSelectFrame = self.authorizedCameraView.isSelectFrameImagesIndex
            self.navigationController?.pushViewController(pressShutterVC, animated: false)
        }
    }
}
