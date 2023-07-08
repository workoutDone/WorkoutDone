//
//  DuringSetFooterView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/29.
//

import UIKit

protocol DuringSetFooterDelegate : AnyObject {
    func addWorkoutButtonTapped()
}

class DuringSetFooterCell : UITableViewHeaderFooterView {
    var delegate : DuringSetFooterDelegate?
    static let footerViewID = "DuringSetFooterCell"
    
    private let backView = UIView()
    
    private let dotLineImageView = UIImageView().then {
        $0.image = UIImage(named: "dotLineImage")
        $0.isUserInteractionEnabled = true
    }
    let addWorkoutButton = UIButton().then {
        $0.setImage(UIImage(named: "plusImage"), for: .normal)
        $0.setTitle("세트 추가", for: .normal)
        $0.titleLabel?.font = .pretendard(.regular, size: 16)
        $0.setTitleColor(UIColor.colorC884FF, for: .normal)
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
        action()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
        setupConstraints()
        action()
    }
    
    private func action() {
        addWorkoutButton.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
        print("여기는?")
    }
    @objc func addWorkoutButtonTapped() {
        delegate?.addWorkoutButtonTapped()
    }
    
    private func setupLayout() {
        self.contentView.addSubview(backView)
        backView.addSubview(dotLineImageView)
        dotLineImageView.addSubview(addWorkoutButton)
    }
    private func setupConstraints() {
        backView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalToSuperview().inset(7)
        }
        dotLineImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(14)
            $0.height.equalTo(50)
        }
        addWorkoutButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
            
        }
    }
}
