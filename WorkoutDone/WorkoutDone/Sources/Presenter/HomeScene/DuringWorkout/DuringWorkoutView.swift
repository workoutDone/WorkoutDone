//
//  DuringWorkoutView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/19.
//

import UIKit
import SnapKit
import Then

class DuringWorkoutView : UIView {

    private let contentView = UIView()

    private let workoutTitleLabel = UILabel().then {
        $0.text = "덤벨프레스"
        $0.textColor = .color000000
        $0.font = .pretendard(.semiBold, size: 20)
    }
    private let timerLabel = UILabel().then {
        $0.text = "00:08:34"
        $0.textColor = .color000000
        $0.font = .pretendard(.regular, size: 16)
    }

    private let playButton = UIButton().then {
        $0.setImage(UIImage(systemName: "play.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 41, weight: .bold)), for: .normal)
    }

    private let separateView = UIView().then {
        $0.backgroundColor = .color7442FF
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setComponents()
        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setComponents()
        setupConstraints()
        setupLayout()
        fatalError("init(coder:) has not been implemented")
    }

    private func setComponents() {
        self.backgroundColor = .colorFFFFFF
    }

    func setupConstraints() {
        self.addSubview(contentView)
        contentView.addSubviews(workoutTitleLabel)
    }

    func setupLayout() {
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        workoutTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(56)
        }
    }
}
