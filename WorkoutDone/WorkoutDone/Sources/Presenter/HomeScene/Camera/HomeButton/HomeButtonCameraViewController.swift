//
//  HomeButtonCameraViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/17.
//

import UIKit
import SnapKit
import Then

class HomeButtonCameraViewController : BaseViewController {
    let cameraViewHeight: Int = 468
    
    private let cameraView = UIView().then {
        $0.backgroundColor = .blue
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
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        [cameraView, backButton, gridToggleButton, collectionView, shutterButton, switchCameraButton, pressShutterView].forEach {
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
        }
        
        gridRowLine2.snp.makeConstraints {
            $0.top.equalTo(cameraView).offset((cameraViewHeight / 3) * 2)
            $0.leading.trailing.equalTo(cameraView)
        }
        
        gridColumnLine1.snp.makeConstraints {
            $0.leading.equalTo(cameraView).offset(view.bounds.width / 3)
            $0.top.bottom.equalTo(cameraView)
        }
        
        gridColumnLine2.snp.makeConstraints {
            $0.leading.equalTo(cameraView).offset((view.bounds.width / 3) * 2)
            $0.top.bottom.equalTo(cameraView)
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
    }
    
    @objc func switchCameraButtonTapped(sender: UIButton!) {
        print(2)
    }
    
}

extension HomeButtonCameraViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FrameCell", for: indexPath) as? FrameCell else { return UICollectionViewCell() }
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
