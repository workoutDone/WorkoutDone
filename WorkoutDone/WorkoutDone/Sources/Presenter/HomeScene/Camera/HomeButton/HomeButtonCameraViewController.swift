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
    let cameraViewHeight: Int = 468
    
    var frameImages: [String] = ["frame1", "frame2", "frame3", "frame4", "frame5", "frame6"]
    var isSelectFrameImagesIndex = 0
    var backCameraOn: Bool = true
    
    var captureSession: AVCaptureSession!
    var frontCamera: AVCaptureDevice!
    var backCamera: AVCaptureDevice!
    var frontInput: AVCaptureInput!
    var backInput: AVCaptureInput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoOutput: AVCaptureVideoDataOutput!
    var takePicture = false
    
    private let cameraView = UIView()
    
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
        //        saveButton.isHidden = true
        gridView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //setupCaptureSession()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [cameraView, backButton, gridView, gridToggleButton, collectionView, shutterButton, switchCameraButton, frameImage].forEach {
            view.addSubview($0)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        cameraView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cameraViewHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalTo(cameraView).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        gridToggleButton.snp.makeConstraints {
            $0.top.equalTo(cameraView).offset(23)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        gridView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(cameraView)
        }
        
        frameImage.snp.makeConstraints {
            $0.top.bottom.equalTo(cameraView).offset(10)
            $0.leading.trailing.equalTo(cameraView)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom).offset(20)
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
        
//        pressShutterView.snp.makeConstraints {
//            $0.top.equalTo(cameraView.snp.bottom)
//            $0.bottom.leading.trailing.equalToSuperview()
//        }
        
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
//        pressShutterView.againButton.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
    }
    
    func setDelegateDataSource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setupCaptureSession() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.captureSession = AVCaptureSession()
            self.captureSession.beginConfiguration()
            if self.captureSession.canSetSessionPreset(.photo) {
                self.captureSession.sessionPreset = .photo
            }
            self.captureSession.automaticallyConfiguresCaptureDeviceForWideColor = true
            self.setupInput()
            DispatchQueue.main.async {
                self.setupPreviewLayer()
            }
            self.setupOutput()
            self.captureSession.commitConfiguration()
            self.captureSession.startRunning()
        }
    }
    
    func setupInput() {
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) {
            backCamera = device
        }
        
        if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
            frontCamera = device
        }
        
        guard let bInput = try? AVCaptureDeviceInput(device: backCamera) else {
            return
        }
        backInput = bInput
    
        
        guard let fInput = try? AVCaptureDeviceInput(device: frontCamera) else {
            return
        }
        frontInput = fInput
        
        captureSession.addInput(backInput)
    }
    
    func setupOutput() {
        videoOutput = AVCaptureVideoDataOutput()
        let videoQueue = DispatchQueue(label: "videoQueue", qos: .userInteractive)
        videoOutput.setSampleBufferDelegate(self, queue: videoQueue)
        
        if captureSession.canAddOutput(videoOutput) {
            captureSession.addOutput(videoOutput)
        }
        
        videoOutput.connections.first?.videoOrientation = .portrait
    }
    
    func setupPreviewLayer() {
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        cameraView.layer.insertSublayer(previewLayer, below: switchCameraButton.layer)
        previewLayer.frame = self.cameraView.layer.frame
    }
    
    func switchCameraInput() {
        switchCameraButton.isUserInteractionEnabled = false
        
        captureSession.beginConfiguration()
        if backCameraOn {
            captureSession.removeInput(backInput)
            captureSession.addInput(frontInput)
        } else {
            captureSession.removeInput(frontInput)
            captureSession.addInput(backInput)
        }
        
        backCameraOn = !backCameraOn
        
        videoOutput.connections.first?.videoOrientation = .portrait
        videoOutput.connections.first?.isVideoMirrored = !backCameraOn
        captureSession.commitConfiguration()
        switchCameraButton.isUserInteractionEnabled = true
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
        takePicture = true
        
        let pressShutterVC = PressShutterViewController()
        pressShutterVC.frameImage.image = UIImage(named: self.frameImages[self.isSelectFrameImagesIndex])
        self.navigationController?.pushViewController(pressShutterVC, animated: false)
    }
    
    @objc func switchCameraButtonTapped(sender: UIButton!) {
        switchCameraInput()
    }
    
    @objc func againButtonTapped(sender: UIButton!) {
        
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
            frameImage.image = UIImage(named: frameImages[indexPath.row])
        }
        collectionView.reloadData()
    }
}

extension HomeButtonCameraViewController : AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if !takePicture {
            return
        }
        
        guard let cvBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let ciImage = CIImage(cvImageBuffer: cvBuffer)
        
        let uiImage = UIImage(ciImage: ciImage)
        
        DispatchQueue.main.async {
            let pressShutterVC = PressShutterViewController()
            pressShutterVC.captureImage.image = uiImage
            pressShutterVC.frameImage.image = UIImage(named: self.frameImages[self.isSelectFrameImagesIndex])
            self.navigationController?.pushViewController(pressShutterVC, animated: false)
            
            self.takePicture = false
            self.captureSession.stopRunning()
        }
    }
}


