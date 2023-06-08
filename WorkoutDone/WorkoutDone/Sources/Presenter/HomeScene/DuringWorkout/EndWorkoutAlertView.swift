//
//  EndWorkoutAlertView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/08.
//

import UIKit

class EndWorkoutAlertView : UIView {
    
    //MARK: - UI Components
    var deleteAlertView = DeleteAlertView(
        deleteButtonTitle: "네, 저장할게요",
        title: "운동을 저장하고 \n종료할까요?",
        hasSubTitle: false,
        subTitle: "")
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffectView.frame = self.frame
        self.addSubview(visualEffectView)
        
        deleteAlertView.cancelButton.setTitle("취소할래요", for: .normal)
        self.addSubview(deleteAlertView)
        deleteAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
