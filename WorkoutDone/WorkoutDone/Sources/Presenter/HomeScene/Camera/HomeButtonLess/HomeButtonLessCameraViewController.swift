//
//  HomeButtonLessCameraViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/15.
//

import UIKit
import SnapKit
import Then
import AVFoundation

final class HomeButtonLessCameraViewController : BaseViewController {
    

    private var isSelectFrameImagesIndex = 0
    private let captureSettion = AVCaptureSession()
    private var videoDeviceInput : AVCaptureDeviceInput!
    private let photoOutput = AVCapturePhotoOutput()
    private var isBack : Bool = true
    
    private let captureDevice = AVCaptureDevice.default(for: .video)
    private let sesstionQueue = DispatchQueue(label: "sesstion Queue")
    private let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera, .builtInTelephotoCamera], mediaType: .video, position: .unspecified)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
            hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let deniedCameraView = PermissionDeniedView(permissionTitle: "카메라")
    private let authorizedCameraView = AuthorizedCameraView()
    
    private let gridToggleButton = GridToggleButton()

    private var frameButtons = [UIButton]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuth()
    }
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(deniedCameraView, authorizedCameraView)
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        let barButton = UIBarButtonItem()
        barButton.customView = gridToggleButton
        navigationItem.rightBarButtonItem = barButton
        navigationController?.isNavigationBarHidden = false
        deniedCameraView.isHidden = true
        authorizedCameraView.isHidden = true
        

        [authorizedCameraView.defaultFrameButton, authorizedCameraView.manFirstUpperBodyFrameButton, authorizedCameraView.manSecondUpperBodyFrameButton, authorizedCameraView.manWholeBodyFrameButton, authorizedCameraView.womanFirstUpperBodyFrameButton, authorizedCameraView.womanSecondUpperBodyFrameButton, authorizedCameraView.womanWholeBodyFrameButton].forEach {
            frameButtons.append($0)
        }
        
        authorizedCameraView.defaultFrameButton.tag = 0
        authorizedCameraView.manFirstUpperBodyFrameButton.tag = 1
        authorizedCameraView.manSecondUpperBodyFrameButton.tag = 3
        authorizedCameraView.manWholeBodyFrameButton.tag = 5
        authorizedCameraView.womanFirstUpperBodyFrameButton.tag = 2
        authorizedCameraView.womanSecondUpperBodyFrameButton.tag = 4
        authorizedCameraView.womanWholeBodyFrameButton.tag = 6
        
        authorizedCameraView.defaultFrameButton.layer.borderWidth = 2
        authorizedCameraView.defaultFrameButton.layer.borderColor = UIColor.color7442FF.cgColor
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchCamera))
        authorizedCameraView.previewView.addGestureRecognizer(pinchRecognizer)
    }
    override func setupConstraints() {
        super.setupConstraints()
        deniedCameraView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        authorizedCameraView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
    }


    override func actions() {
        super.actions()
        deniedCameraView.permisstionButton.addTarget(self, action: #selector(permisstionButtonTapped), for: .touchUpInside)
        gridToggleButton.addTarget(self, action: #selector(gridToggleButtonTapped), for: .touchUpInside)
        authorizedCameraView.captureButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        frameButtons.forEach {
            $0.addTarget(self, action: #selector(frameButtonTapped(sender: )), for: .touchUpInside)
        }
        authorizedCameraView.switchCameraButton.addTarget(self, action: #selector(switchCameraButtonTapped), for: .touchUpInside)
    }
    @objc func switchCameraButtonTapped() {
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
                    }
                    
                } catch let error  {
                    print("error occured while creating device input : \(error.localizedDescription)")
                }
            }
        }
    }
    @objc func frameButtonTapped(sender: UIButton) {
        for button in frameButtons {
            if button == sender {
                print(button.tag)
                if button.tag == 0 {
                    authorizedCameraView.frameImageView.image = .none
                }
                else {
                    authorizedCameraView.frameImageView.image = UIImage(named: "cameraFrame\(button.tag)")
                }
                button.layer.borderWidth = 2
                button.layer.borderColor = UIColor.color7442FF.cgColor
                if button.tag == 0 {
                    button.setImage(UIImage(named: "selectedDefaultImage"), for: .normal)
                }
            }
            else {
                button.layer.borderColor = UIColor.colorCCCCCC.cgColor
                button.layer.borderWidth = 1
                if button.tag == 0 {
                    button.setImage(UIImage(named: "unselectedDefaultImage"), for: .normal)
                }
            }
        }
    }
    @objc func captureButtonTapped() {

        let videoPreviewLayerOrientation = self.authorizedCameraView.previewView.previewLayer.connection?.videoOrientation
        sesstionQueue.async {
            let connection = self.photoOutput.connection(with: .video)
            connection?.videoOrientation = videoPreviewLayerOrientation!
            let setting = AVCapturePhotoSettings()
            self.photoOutput.capturePhoto(with: setting, delegate: self)
            
        }
    }
    @objc func permisstionButtonTapped() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    }
    @objc func gridToggleButtonTapped(sender: UIButton!) {
        if gridToggleButton.isOnToggle {
            authorizedCameraView.gridImageView.isHidden = true
        }
        else {
            authorizedCameraView.gridImageView.isHidden = false
        }
        gridToggleButton.changeToggle()
        gridToggleButton.isOnToggle = !gridToggleButton.isOnToggle
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
extension HomeButtonLessCameraViewController {
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

extension HomeButtonLessCameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        guard error == nil else { return }
        guard let imageData = photo.fileDataRepresentation() else { return }
        guard let image = UIImage(data: imageData) else { return }
        let flippedImage = UIImage(cgImage: image.cgImage!, scale: image.scale, orientation: .leftMirrored)
       
        DispatchQueue.main.async {
            let pressShutterVC = HomeButtonLessPressShutterViewController()
            pressShutterVC.captureImage = self.isBack ? image : flippedImage
            pressShutterVC.isSelectFrame = self.isSelectFrameImagesIndex
            self.navigationController?.pushViewController(pressShutterVC, animated: false)
        }
    }
    
}
