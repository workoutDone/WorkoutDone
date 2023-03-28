//
//  GalleryViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/24.
//

import UIKit
import SnapKit
import Then

class GalleryViewController : BaseViewController {
    var sortByFrame : Bool = false
    
    private let scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let contentView = UIView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let sortButton = UIButton().then {
        $0.backgroundColor = .colorF8F6FF
        $0.layer.cornerRadius = 5
    }
    
    let sortLabel = UILabel().then {
        $0.text = "프레임 모아보기"
        $0.textColor = .color7442FF
        $0.font = .pretendard(.semiBold, size: 16)
    }
    
    let sortByMonthView = SortByMonthView()
    
    let sortByFrameView = SortByFrameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupLayout() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(sortButton)
        sortButton.addSubview(sortLabel)
        
        contentView.addSubview(sortByMonthView)
        //contentView.addSubview(sortByFrameView)
    }
    
    override func setComponents() {
        sortButton.addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
        sortByFrameView.isHidden = true
    }
    
    override func setupConstraints() {
        scrollView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.leading.trailing.top.bottom.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(19)
            $0.trailing.equalToSuperview().offset(-22)
            $0.width.equalTo(119)
            $0.height.equalTo(30)
        }
        
        sortLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(sortButton)
        }
        
        sortByMonthView.snp.makeConstraints {
            $0.top.equalTo(sortButton.snp.bottom).offset(30)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-30)
        }
        
//        sortByFrameView.snp.makeConstraints {
//            $0.top.equalTo(sortButton.snp.bottom).offset(30)
//            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-30)
//        }
    }
    
    @objc func sortButtonTapped(sender: UIButton!) {
        if sortByFrame {
            sortLabel.text = "프레임 모아보기"
            sortButton.snp.updateConstraints {
                $0.width.equalTo(119)
            }
        } else {
            sortLabel.text = "월별 정렬"
            sortButton.snp.updateConstraints {
                $0.width.equalTo(80)
            }
        }
        
        sortByFrame = !sortByFrame
    }
}

