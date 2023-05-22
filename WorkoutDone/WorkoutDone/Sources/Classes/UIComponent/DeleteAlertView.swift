//
//  DeleteAlertView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/22.
//

import UIKit
import SnapKit
import Then

class DeleteAlertView : UIView {
    //MARK: - Properties
    var deleteButtonTitle : String
    var title : String
    var hasSubTitle : Bool
    var subTitle : String
    
    //MARK: - UI Components
    private let alertBackView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
        $0.layer.cornerRadius = 15
    }
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    private lazy var alertTitleLabel = UILabel().then {
        $0.text = title
        $0.font = UIFont.pretendard(.semiBold, size: 20)
        $0.textColor = .color121212
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    private lazy var alertSubTitleLabel = UILabel().then {
        $0.text = subTitle
        $0.font = UIFont.pretendard(.regular, size: 14)
        $0.textColor = .color5E5E5E
    }
    
    let cancelButton = UIButton().then {
        $0.setTitle("아니요", for: .normal)
        $0.setTitleColor(UIColor.color5E5E5E, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.color929292.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
    }
    
    
    lazy var deleteButton = UIButton().then {
        $0.setTitle(deleteButtonTitle, for: .normal)
        $0.setTitleColor(UIColor.colorFFFFFF, for: .normal)
        $0.layer.cornerRadius = 10
        $0.layer.borderColor = UIColor.colorF54968.cgColor
        $0.layer.borderWidth = 1
        $0.titleLabel?.font = UIFont.pretendard(.semiBold, size: 16)
        $0.backgroundColor = UIColor.colorF54968
    }
    
    init(deleteButtonTitle: String, title: String, hasSubTitle: Bool, subTitle: String) {
        self.deleteButtonTitle = deleteButtonTitle
        self.title = title
        self.hasSubTitle = hasSubTitle
        self.subTitle = subTitle
        
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    private func setUI() {
//        self.backgroundColor = .colorFFFFFF

    }
    
    private func setLayout() {
        self.backgroundColor = UIColor(hex: 0x000000, alpha: 0.15)
        visualEffectView.frame = self.frame
        self.addSubviews(visualEffectView, alertBackView)
        alertBackView.addSubviews(alertTitleLabel, cancelButton, deleteButton, alertSubTitleLabel)
        
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
        if hasSubTitle {
            alertTitleLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(55)
            }
            alertSubTitleLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(alertTitleLabel.snp.bottom).offset(11)
            }
        }
        else {
            alertTitleLabel.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(47)
            }
            alertSubTitleLabel.isHidden = true
        }
    }
}
