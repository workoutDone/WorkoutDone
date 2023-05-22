//
//  DeleteRecordAlertView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/22.
//

import UIKit

class DeleteRecordAlertView : UIView {
    
    //MARK: - UI Components
    var deleteAlertView = DeleteAlertView(
        deleteButtonTitle: "네, 지울래요",
        title: "오늘의 운동 결과를 \n삭제할까요?",
        hasSubTitle: false,
        subTitle: "")
    
    //MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.addSubview(deleteAlertView)
        deleteAlertView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
