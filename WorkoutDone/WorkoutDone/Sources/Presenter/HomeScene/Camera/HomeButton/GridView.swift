//
//  GridView.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/04/05.
//

//import UIKit
//import SnapKit
//import Then
//
//class GridView: BaseUIView {
//    let cameraViewHeight: Int = 468
//
//    private let gridRowLine1 = UIImageView().then {
//        $0.image = UIImage(named: "rowLine")
//    }
//
//    private let gridRowLine2 = UIImageView().then {
//        $0.image = UIImage(named: "rowLine")
//    }
//
//    private let gridColumnLine1 = UIImageView().then {
//        $0.image = UIImage(named: "columnLine")
//    }
//
//    private let gridColumnLine2 = UIImageView().then {
//        $0.image = UIImage(named: "columnLine")
//    }
//
//    override func setupLayout() {
//        super.setupLayout()
//
//        [gridRowLine1, gridRowLine2, gridColumnLine1, gridColumnLine2].forEach {
//            self.addSubview($0)
//        }
//    }
//
//    override func setupConstraints() {
//        super.setupConstraints()
//
//        gridRowLine1.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(cameraViewHeight / 3 + 10)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(0.5)
//        }
//
//        gridRowLine2.snp.makeConstraints {
//            $0.top.equalToSuperview().offset((cameraViewHeight / 3) * 2 + 10)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(0.5)
//        }
//
//        gridColumnLine1.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(UIScreen.main.bounds.width / 3)
//            $0.top.bottom.equalToSuperview().offset(10)
//            $0.width.equalTo(0.5)
//        }
//
//        gridColumnLine2.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset((UIScreen.main.bounds.width / 3) * 2)
//            $0.top.bottom.equalToSuperview().offset(10)
//            $0.width.equalTo(0.5)
//        }
//    }
//
//}
