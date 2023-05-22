//
//  PermissionDeniedView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/22.
//

import UIKit
import SnapKit
import Then

class PermissionDeniedView : UIView {
    //MARK: - Properties
    var permissionTitle : String
    
    //MARK: - UI Components
    private lazy var contentStackView : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infoLabel, permisstionButton])
        stackView.axis = .vertical
        stackView.spacing = 25
        stackView.alignment = .center
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var infoLabel = UILabel().then {
        $0.text = "\(permissionTitle) 권한을 가지고 있지 않아요!"
        $0.font = .pretendard(.regular, size: 15)
        $0.textColor = .color929292
    }
    
    let permisstionButton = UIButton().then {
        $0.setTitle("권한 설정하기", for: .normal)
        $0.backgroundColor = .colorF3F3F3
        $0.setTitleColor(UIColor.color5E5E5E, for: .normal)
        $0.titleLabel?.font = UIFont.pretendard(.medium, size: 16)
        $0.layer.cornerRadius = 12
    }
    
    init(permissionTitle: String) {
        self.permissionTitle = permissionTitle
        super.init(frame: .zero)
        
        setUI()
        setLayout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Custom Method
    private func setUI() {
        self.backgroundColor = .colorFFFFFF

    }
    
    private func setLayout() {
        self.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        permisstionButton.snp.makeConstraints {
            $0.height.equalTo(58)
            $0.width.equalTo(163)
        }
    }
}
