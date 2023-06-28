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
        
        setDeleteRoutineButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setDeleteRoutineButton() {
        self.backgroundColor = .colorFFEDF0
        self.setTitle("루틴 삭제", for: .normal)
        self.setTitleColor(.colorF54968, for: .normal)
        self.titleLabel?.font = .pretendard(.semiBold, size: 16)
        
        self.layer.cornerRadius = 5
    }
    
    func setText(_ text: String) {
        self.setTitle(text, for: .normal)
    }
}
