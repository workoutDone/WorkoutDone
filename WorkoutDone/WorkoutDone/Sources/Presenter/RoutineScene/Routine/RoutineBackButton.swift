//
//  RoutineBackButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/24.
//

import UIKit

class RoutineBackButton: UIButton {
    private let backButtonImage = UIImageView().then {
        $0.image = UIImage(named: "routineBackButton")
        //$0.image = UIImage(systemName: "chevron.backward")
        $0.tintColor = .color000000
    }
    
    private let backButtonLabel = UILabel().then {
        $0.text = "뒤로가기"
        $0.font = .systemFont(ofSize: 17)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setLayout()
        setConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout() {
        self.addSubview(backButtonImage)
        self.addSubview(backButtonLabel)
    }
    
    func setConstraints() {
        backButtonImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(-7)
            $0.width.equalTo(10.5)
            $0.height.equalTo(18.5)
        }

        backButtonLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(backButtonImage.snp.trailing).offset(9.5)
        }
    }
}
