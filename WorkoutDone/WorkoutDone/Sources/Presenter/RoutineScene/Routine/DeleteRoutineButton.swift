//
//  DeleteRoutineButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

class DeleteRoutineButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupDeleteRoutineButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func setupDeleteRoutineButton() {
        setDeleteRoutineButton(text: "루틴 삭제", textColor: .colorF54968, backgroundColor: .colorFFEDF0)
    }
    
    func setDeleteRoutineButton(text: String, textColor: UIColor,  backgroundColor: UIColor) {
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
        self.backgroundColor = backgroundColor
        
        self.titleLabel?.font = .pretendard(.semiBold, size: 16)
        
        self.layer.cornerRadius = 5
    }
}
