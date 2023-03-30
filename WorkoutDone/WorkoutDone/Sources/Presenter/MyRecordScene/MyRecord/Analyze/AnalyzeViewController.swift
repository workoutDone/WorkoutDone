//
//  AnalyzeViewController.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/24.
//

import UIKit
import SwiftUI
import SnapKit
import Then


class AnalyzeViewController : BaseViewController {
    private let contentScrollView = UIScrollView()
    
    private let contentView = UIView().then {
        $0.backgroundColor = .colorFFFFFF
    }
    
    private let weightLabel = UILabel().then {
        $0.text = "체중 변화"
        $0.textColor = .color121212
        $0.font = .pretendard(.bold, size: 20)
    }
    private var weightGraphView = UIView()
    
    private let skeletalMuscleMassLabel = UILabel().then {
        $0.text = "골격근량"
        $0.textColor = .color121212
        $0.font = .pretendard(.bold, size: 20)
    }
    
    private var skeletalMuscleMassGraphView = UIView()
    
    private let fatPercentageLabel = UILabel().then {
        $0.text = "체지방량"
        $0.textColor = .color121212
        $0.font = .pretendard(.bold, size: 20)
    }
    
    
    private var fatPercentageGraphView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupLayout() {
        super.setupLayout()
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentView)
        weightGraphView = UIHostingController(rootView: WeightGraphView()).view
        skeletalMuscleMassGraphView = UIHostingController(rootView: EmptyView()).view
        fatPercentageGraphView = UIHostingController(rootView: EmptyView()).view
        [weightLabel, weightGraphView, skeletalMuscleMassLabel, skeletalMuscleMassGraphView, fatPercentageLabel, fatPercentageGraphView].forEach {
            contentView.addSubview($0)
        }
    }
    override func setComponents() {
        super.setComponents()
        view.backgroundColor = .colorFFFFFF
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.isUserInteractionEnabled = true
        contentScrollView.isScrollEnabled = true
        contentScrollView.isUserInteractionEnabled = true
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        contentScrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.bottom.equalToSuperview()
        }
        weightLabel.snp.makeConstraints {
            $0.top.equalTo(contentView.snp.top).offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        weightGraphView.snp.makeConstraints {
            $0.top.equalTo(weightLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(220)
        }
        skeletalMuscleMassLabel.snp.makeConstraints {
            $0.top.equalTo(weightGraphView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        skeletalMuscleMassGraphView.snp.makeConstraints {
            $0.top.equalTo(skeletalMuscleMassLabel.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(15)
            $0.height.equalTo(220)
        }
        fatPercentageLabel.snp.makeConstraints {
            $0.top.equalTo(skeletalMuscleMassGraphView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(24)
        }
        fatPercentageGraphView.snp.makeConstraints {
            $0.top.equalTo(fatPercentageLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.height.equalTo(220)
            $0.bottom.equalToSuperview().offset(-30)
        }
    }
    
}
