//
//  SortButtonCell.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/31.
//

import UIKit

protocol SortButtonTappedDelegate : AnyObject {
    func sortButtonTapped(sortDelegate: Bool)
}

class SortButtonCell : UICollectionViewCell {
    var delegate : SortButtonTappedDelegate?
    
    var sortFrame : Bool = false
    
    let sortButton = UIButton().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 5
    }
    
    let sortLabel = UILabel().then {
        $0.text = "프레임 모아보기"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    // MARK: - LIFECYCLE
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupConstraints()
        
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

    }
    
    // MARK: - ACTIONS
    func setupLayout() {
        addSubview(sortButton)
        sortButton.addSubview(sortLabel)
    }
    
    func setupConstraints() {
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-7)
            $0.width.equalTo(115)
            $0.height.equalTo(30)
        }
        
        sortLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(sortButton)
        }
    }
    
    @objc func sortButtonTapped() {
        
        if !sortFrame {
            sortLabel.text = "월별 정렬"
            
            sortButton.snp.updateConstraints {
                $0.width.equalTo(80)
            }
        } else {
            sortLabel.text = "프레임 모아보기"
            
            sortButton.snp.updateConstraints {
                $0.width.equalTo(115)
            }
        }
        
        sortFrame = !sortFrame
        delegate?.sortButtonTapped(sortDelegate: sortFrame)
    }
}
