//
//  EditButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/01.
//

import UIKit

class EditButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setAddOrRemoveButton()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddOrRemoveButton() {
        self.backgroundColor = .colorF3F3F3
        self.setTitleColor(.color363636, for: .normal)
        self.titleLabel?.font = .pretendard(.semiBold, size: 16)
        self.layer.cornerRadius = 5
    }
    
    func setText(_ text: String) {
        self.setTitle(text, for: .normal)
    }
}


