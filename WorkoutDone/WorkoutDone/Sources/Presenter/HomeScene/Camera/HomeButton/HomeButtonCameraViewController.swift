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

class HomeButtonCameraViewController : BaseViewController {
    
    var frameImages: [String] = ["frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
    var isSelectFrameImagesIndex = 0
    var backCameraOn: Bool = true
    
    var takePicture = false
    let captureSettion = AVCaptureSession()
    var videoDeviceInput : AVCaptureDeviceInput!
    let photoOutput = AVCapturePhotoOutput()
    var isBack : Bool = true
    
    let sesstionQueue = DispatchQueue(label: "sesstion Queue")
    let videoDeviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera, .builtInTrueDepthCamera, .builtInTrueDepthCamera], mediaType: .video, position: .unspecified)
    

    let previewView = PreviewView()
    
    private let frameImage = UIImageView()
    
    private let backButton = BackButton()
    
    private let gridToggleButton = GridToggleButton()
    
    private let gridView = GridView()
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(FrameCell.self, forCellWithReuseIdentifier: "FrameCell")
        collectionView.showsHorizontalScrollIndicator = false
        
        return collectionView
    }()
    
    private let shutterButton = UIButton().then {
        $0.setImage(UIImage(named: "shutter"), for: .normal)
    }
    
    private let switchCameraButton = UIButton().then {
        $0.setImage(UIImage(named: "switchCamera"), for: .normal)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegateDataSource()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        previewView.session = captureSettion
        sesstionQueue.async {
            self.setupSession()
            self.startSession()
        }
    }
    
    override func setComponents() {
        //saveButton.isHidden = true
        gridView.isHidden = true
        view.backgroundColor = .colorFFFFFF
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [previewView, gridView, backButton, gridToggleButton, collectionView, shutterButton, switchCameraButton, frameImage].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    
        previewView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(previewView).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        gridToggleButton.snp.makeConstraints {
            $0.top.equalTo(previewView).offset(23)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        gridView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(previewView)
        }
        
        frameImage.snp.makeConstraints {
            $0.top.bottom.equalTo(previewView).offset(10)
            $0.leading.trailing.equalTo(previewView)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(previewView.snp.bottom).offset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(66)
        }
        
        shutterButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.width.height.equalTo(50)
        }
        
        switchCameraButton.snp.makeConstraints {
            $0.bottom.equalTo(shutterButton)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-17)
            $0.width.height.equalTo(42)
        }
        
//        saveButton.snp.makeConstraints {
//            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-13)
//            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
//            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)
//            $0.height.equalTo(58)
//        }
    }
    
    override func actions() {
        shutterButton.addTarget(self, action: #selector(captureButtonTapped), for: .touchUpInside)
        switchCameraButton.addTarget(self, action: #selector(switchCameraButtonTapped), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        gridToggleButton.addTarget(self, action: #selector(gridToggleButtonTapped), for: .touchUpInside)
    }
    
    func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @objc func backButtonTapped(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func gridToggleButtonTapped(sender: UIButton!) {
        if gridToggleButton.isOnToggle {
           gridView.isHidden = true
            
        } else {
            gridView.isHidden = false
        }
        gridToggleButton.changeToggle()
        gridToggleButton.isOnToggle = !gridToggleButton.isOnToggle
    }

    @objc func captureButtonTapped(sender: UIButton!) {
        let videoPreviewLayerOrientaion = self.previewView.previewLayer.connection?.videoOrientation
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
                        self.previewView.session = self.captureSettion
                    }
                    
                } catch let error  {
                    print("error occured while creating device input : \(error.localizedDescription)")
                }
            }
        }
    }
}

extension HomeButtonCameraViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return frameImages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameCell", for: indexPath) as? FrameCell else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            cell.frameImage.image = nil
            cell.basicLabel.isHidden = false
        } else {
            cell.frameImage.image = UIImage(named: frameImages[indexPath.row - 1])
            cell.basicLabel.isHidden = true
        }
        
        if indexPath.row == isSelectFrameImagesIndex {
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.color7442FF.cgColor
            cell.backgroundColor = .colorE6E0FF
        } else {
            cell.layer.borderWidth = 0
            cell.backgroundColor = .clear
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 66 , height: 66)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        isSelectFrameImagesIndex = indexPath.row
        if indexPath.row == 0 {
            frameImage.image = nil
        } else {
            frameImage.image = UIImage(named: frameImages[indexPath.row - 1])
        }
        collectionView.reloadData()
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
            pressShutterVC.isSelectFrame = self.isSelectFrameImagesIndex
            self.navigationController?.pushViewController(pressShutterVC, animated: false)
        }
    }
}
