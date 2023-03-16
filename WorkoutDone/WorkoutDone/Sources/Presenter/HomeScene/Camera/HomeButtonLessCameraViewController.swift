//
//  HomeButtonLessCameraViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/15.
//

import UIKit
import SnapKit
import Then

class HomeButtonLessCameraViewController : BaseViewController {
    
    private let preview = UIView()
    
    private let captureButton = UIButton()
    
    private let switchCameraButton = UIButton()
    
    private let captureAgainButton = UIButton()
    
    private let frameImageView = UIImageView()
    
    private let gridImageView = UIImageView()
    
    private let frameTypeScrollView = UIScrollView()
    
    private let frameTypeBaseView = UIView()
    
    ///프레임 타입 버튼
    private let defaultFrameButton = UIButton()
    
    private let manFirstUpperBodyFrameButton = UIButton()
    
    private let manSecondUpperBodyFrameButton = UIButton()
    
    private let manWholeBodyFrameButton = UIButton()
    
    private let womanFirstUpperBodyFrameButton = UIButton()
    
    private let womanSecondUpperBodyFrameButton = UIButton()
    
    private let womanWholeBodyFrameButton = UIButton()
    
    private let frameButtons = [UIButton]()
    
    override func setupLayout() {
        super.setupLayout()
    }
    override func setupConstraints() {
        super.setupConstraints()
    }
}
