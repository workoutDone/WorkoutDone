//
//  DeleteRecordAlertViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/13.
//

import UIKit
import SnapKit
import Then
import RxSwift
import RxCocoa

class DeleteRecordAlertViewController : BaseViewController {
    
    // MARK: - ViewModel
    
    // MARK: - PROPERTIES
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    private let alertBackView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
    }
    private lazy var alertTitleLabel = UILabel().then {
        $0.text = "운동을 저장하고 \n종료할까요?"
        $0.font = UIFont.pretendard(.semiBold, size: 20)
        $0.textColor = .color121212
        $0.numberOfLines = 2
        $0.textAlignment = .center
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
        visualEffectView.frame = view.frame
    }
    
    override func setupLayout() {
        super.setupLayout()
        view.addSubviews(visualEffectView, alertBackView)
        alertBackView.addSubviews(alertTitleLabel, cancelButton, deleteButton)
    }
    override func setupConstraints() {
        super.setupConstraints()
        alertBackView.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
            $0.height.equalTo(227)
            $0.width.equalTo(267)
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
        alertTitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(47)
        }
    }
    
    // MARK: - ACTIONS
    override func actions() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
}
// MARK: - EXTENSIONs
extension DeleteRecordAlertViewController {
    
}

