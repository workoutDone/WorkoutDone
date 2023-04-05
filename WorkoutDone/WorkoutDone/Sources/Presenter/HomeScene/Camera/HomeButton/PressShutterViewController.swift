//
//  PressShutterViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/04/06.
//

import UIKit

class PressShutterViewController: BaseViewController {
    
    let cameraViewHeight: Int = 468
    
    var captureImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        view.addSubview(captureImage)
    }
    
    override func setupConstraints() {
        captureImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(22)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(cameraViewHeight)
        }
    }
    
}
