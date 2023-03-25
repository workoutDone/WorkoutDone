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
    var backCameraOn = true
    
    var captureSession: AVCaptureSession!
    var frontCamera: AVCaptureDevice!
    var backCamera: AVCaptureDevice!
    var frontInput: AVCaptureInput!
    var backInput: AVCaptureInput!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var videoOutput: AVCaptureVideoDataOutput!
    var takePicture = false
    
    private let cameraView = UIView().then {
        $0.backgroundColor = .blue
    }
    
    private let captureImage = UIImageView().then {
        $0.backgroundColor = .yellow
    }
    
    private let backButton = BackButton()
    
    private let gridToggleButton = GridToggleButton()
    
    private let gridRowLine1 = UIImageView().then {
        $0.image = UIImage(named: "rowLine")
    }
    
    private let gridRowLine2 = UIImageView().then {
        $0.image = UIImage(named: "rowLine")
    }
    
    private let gridColumnLine1 = UIImageView().then {
        $0.image = UIImage(named: "columnLine")
    }
    
    private let gridColumnLine2 = UIImageView().then {
        $0.image = UIImage(named: "columnLine")
    }
    
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
    
    private let pressShutterView = PressShutterView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegateDataSource()
        pressShutterView.isHidden = true
        //        saveButton.isHidden = true
        captureImage.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupCaptureSession()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [cameraView, captureImage, backButton, gridToggleButton, collectionView, shutterButton, switchCameraButton, pressShutterView].forEach {
            view.addSubview($0)
        }
        
        cameraView.addSubview(gridRowLine1)
        cameraView.addSubview(gridRowLine2)
        cameraView.addSubview(gridColumnLine1)
        cameraView.addSubview(gridColumnLine2)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        cameraView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cameraViewHeight)
        }
        
        captureImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cameraViewHeight)
        }
        
        backButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(33)
            $0.leading.equalToSuperview().offset(16)
        }
        
        gridToggleButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(36)
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        gridRowLine1.snp.makeConstraints {
            $0.top.equalTo(cameraView).offset(cameraViewHeight / 3)
            $0.leading.trailing.equalTo(cameraView)
            $0.height.equalTo(0.5)
        }
        
        gridRowLine2.snp.makeConstraints {
            $0.top.equalTo(cameraView).offset((cameraViewHeight / 3) * 2)
            $0.leading.trailing.equalTo(cameraView)
            $0.height.equalTo(0.5)
        }
        
        gridColumnLine1.snp.makeConstraints {
            $0.leading.equalTo(cameraView).offset(view.bounds.width / 3)
            $0.top.bottom.equalTo(cameraView)
            $0.width.equalTo(0.5)
        }
        
        gridColumnLine2.snp.makeConstraints {
            $0.leading.equalTo(cameraView).offset((view.bounds.width / 3) * 2)
            $0.top.bottom.equalTo(cameraView)
            $0.width.equalTo(0.5)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom).offset(12)
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
        
        pressShutterView.snp.makeConstraints {
            $0.top.equalTo(cameraView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
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
        pressShutterView.againButton.addTarget(self, action: #selector(againButtonTapped), for: .touchUpInside)
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
            [gridRowLine1, gridRowLine2, gridColumnLine1, gridColumnLine2].forEach {
                $0.isHidden = true
            }
        } else {
            [gridRowLine1, gridRowLine2, gridColumnLine1, gridColumnLine2].forEach {
                $0.isHidden = false
            }
        }
        gridToggleButton.changeToggle()
        gridToggleButton.isOnToggle = !gridToggleButton.isOnToggle
    }

    @objc func captureButtonTapped(sender: UIButton!) {
        collectionView.isHidden = true
        shutterButton.isHidden = true
        switchCameraButton.isHidden = true
        pressShutterView.isHidden = false
        
        takePicture = true
    }
    
    @objc func switchCameraButtonTapped(sender: UIButton!) {
        switchCameraInput()
    }
    
    @objc func againButtonTapped(sender: UIButton!) {
        pressShutterView.isHidden = true
        collectionView.isHidden = false
        shutterButton.isHidden = false
        switchCameraButton.isHidden = false
    }
}

extension HomeButtonCameraViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameCell", for: indexPath) as? FrameCell else { return UICollectionViewCell() }
        if indexPath.row == 0 {
            cell.basicLabel.isHidden = false
            cell.frameImage.isHidden = true
            cell.backgroundColor = .colorE6E0FF
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.color7442FF.cgColor
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
            self.captureImage.image = uiImage
            self.captureImage.isHidden = false
            self.takePicture = false
            self.captureSession.stopRunning()
        }
    }
    
}
