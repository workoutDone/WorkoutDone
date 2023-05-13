//
//  DeleteRecordAlertViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/13.
//

import UIKit
import SnapKit
import Then

class DeleteRecordAlertViewController : BaseViewController {
    // MARK: - PROPERTIES
    private let alertBackView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
    }
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    private let alertTitleLabel = UILabel().then {
        $0.text = "오늘의 운동 결과를 \n삭제할까요?"
        $0.font = UIFont.pretendard(.semiBold, size: 20)
        $0.textColor = .color121212
        $0.numberOfLines = 2
    }
    
    private let cancelButton = UIButton().then {
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(UIColor.color5E5E5E, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.color929292.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
    }
    
    
    private let deleteButton = UIButton().then {
        $0.setTitle("네, 지울래요", for: .normal)
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.colorF54968.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
        $0.backgroundColor = UIColor.colorF54968
    }
    
    // MARK: - LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffectView.frame = view.frame
        
        alertTitleLabel.setLineSpacing(lineHeightMultiple: 1.17)
        alertTitleLabel.textAlignment = .center

    }
    override func setupLayout() {
        [visualEffectView, alertBackView].forEach {
            view.addSubview($0)
        }
        alertBackView.addSubviews(alertTitleLabel, cancelButton, deleteButton)
    }
    override func setupConstraints() {
        alertBackView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(227)
            $0.width.equalTo(267)
        }
        alertTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(47)
        }
        cancelButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.width.equalTo(114)
            $0.bottom.equalToSuperview().inset(15)
            $0.leading.equalToSuperview().inset(14)
        }
        deleteButton.snp.makeConstraints {
            $0.height.equalTo(57)
            $0.width.equalTo(114)
            $0.bottom.equalToSuperview().inset(15)
            $0.trailing.equalToSuperview().inset(14)
        }
    }
    
    // MARK: - ACTIONS
}
// MARK: - EXTENSIONs
extension DeleteRecordAlertViewController {
    
}

