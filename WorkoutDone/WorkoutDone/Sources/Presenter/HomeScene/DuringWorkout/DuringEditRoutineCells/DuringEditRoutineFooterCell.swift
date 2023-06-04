//
//  DuringEditRoutineFooterCell.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/29.
//

import UIKit


protocol DuringEditFooterDelegate : AnyObject {
    func addWorkoutButtonTapped()
}

class DuringEditRoutineFooterCell : UITableViewHeaderFooterView {
    var delegate : DuringEditFooterDelegate?
    static let footerViewID = "DuringEditRoutineFootterCell"
    
    private let backView = UIView()
    
    private let dotLineImageView = UIImageView().then {
        $0.image = UIImage(named: "dotLineImage")
    }
    private let addWorkoutButton = UIButton().then {
        $0.setImage(UIImage(named: "plusImage"), for: .normal)
        $0.setTitle("운동 추가", for: .normal)
        $0.titleLabel?.font = .pretendard(.regular, size: 16)
        $0.setTitleColor(UIColor.colorC884FF, for: .normal)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupLayout()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupLayout() {
        self.addSubview(backView)
        backView.addSubview(dotLineImageView)
        dotLineImageView.addSubview(addWorkoutButton)
        addWorkoutButton.addTarget(self, action: #selector(addWorkoutButtonTapped), for: .touchUpInside)
    }
    @objc func addWorkoutButtonTapped() {
//        handler?()
        delegate?.addWorkoutButtonTapped()
        print("?????????????")
    }
    private func setupConstraints() {
        backView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        dotLineImageView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
        }
        addWorkoutButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
