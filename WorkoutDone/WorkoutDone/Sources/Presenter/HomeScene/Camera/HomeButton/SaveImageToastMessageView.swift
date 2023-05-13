//
//  SaveImageToastMessageViewController.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/04/06.
//

import UIKit

class SaveImageToastMessageViewController: BaseViewController {
    
    private let toastMessageView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
        
        $0.layer.shadowColor = UIColor.color000000.withAlphaComponent(0.25).cgColor
        $0.layer.shadowOpacity = 1
        $0.layer.shadowOffset = CGSize(width: 0, height: 1)
        $0.layer.shadowRadius = 4
    }
    
    let toastMesssageLabel = UILabel().then {
        $0.text = "갤러리에 저장되었습니다"
        $0.font = .pretendard(.medium, size: 14)
    }
    
    override func setComponents() {
        view.backgroundColor = .clear
    }

    override func setupLayout() {
        view.addSubview(toastMessageView)
        toastMessageView.addSubview(toastMesssageLabel)
    }
    
    override func setupConstraints() {
        toastMessageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-46)
            $0.leading.equalTo(toastMesssageLabel.snp.leading).offset(-15)
            $0.trailing.equalTo(toastMesssageLabel.snp.trailing).offset(15)
            $0.height.equalTo(30)
        }
        
        toastMesssageLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
