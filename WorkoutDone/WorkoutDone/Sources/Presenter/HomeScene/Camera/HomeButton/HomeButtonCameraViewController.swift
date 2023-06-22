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
    
//    var frameImages: [String] = ["frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
//    var isSelectFrameImagesIndex = 0
    var backCameraOn: Bool = true
    
    var takePicture = false
    let captureSettion = AVCaptureSession()
    var videoDeviceInput : AVCaptureDeviceInput!
    let photoOutput = AVCapturePhotoOutput()
    var isBack : Bool = true
    
    let sesstionQueue = DispatchQueue(label: "sesstion Queue")
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    
    private let deniedCameraView = PermissionDeniedView(permissionTitle: "카메라")
    private let authorizedCameraView = HomeButtonAuthorizedCameraView()
    
    private let backButton = BackButton()
    
    private let gridToggleButton = GridToggleButton()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuth()
    }

    
    override func setComponents() {
        view.backgroundColor = .colorFFFFFF
        
        deniedCameraView.isHidden = true
        authorizedCameraView.isHidden = true
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
        
    }
    @objc func permisstionButtonTapped() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    @objc func backButtonTapped(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
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
