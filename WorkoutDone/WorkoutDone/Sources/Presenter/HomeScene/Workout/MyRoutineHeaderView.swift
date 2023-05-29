//
//  MyRoutineHeaderView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/27.
//

import UIKit

protocol MyRoutineDelegate : AnyObject {
    func myRoutineButtonTapped()
}

class MyRoutineHeaderView: UICollectionReusableView {
    var isSelected : Bool = true
    
    weak var delegate : MyRoutineDelegate?
    
    var myRoutineButton = UIButton().then {
        $0.setTitle("MY 루틴", for: .normal)
        $0.setTitleColor(.color7442FF, for: .normal)
        $0.titleLabel?.font = .pretendard(.semiBold, size: 16)
        
        $0.layer.cornerRadius = 31 / 2
        $0.backgroundColor = .colorE6E0FF
    }
    
    var lineView = UIView().then {
        $0.backgroundColor = .colorE6E0FF
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupLayout()
        setupConstraints()
        
        myRoutineButton.addTarget(self, action: #selector(myRoutineButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        self.addSubview(myRoutineButton)
        self.addSubview(lineView)
    }
    
    func setupConstraints() {
        myRoutineButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalTo(lineView.snp.leading).offset(-6)
            $0.width.equalTo(81)
            $0.height.equalTo(31)
        }
        
        lineView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(36)
        }
    }
    
    @objc func myRoutineButtonTapped() {
        delegate?.myRoutineButtonTapped()
        
    }
}
