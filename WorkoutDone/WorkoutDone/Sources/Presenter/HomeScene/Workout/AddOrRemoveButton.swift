//
//  addOrRemoveButton.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/01.
//

import UIKit

class AddOrRemoveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setAddOrRemoveButton()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAddOrRemoveButton() {
        self.backgroundColor = .colorF3F3F3
        self.setTitle("추가/삭제", for: .normal)
        self.setTitleColor(.color363636, for: .normal)
        self.titleLabel?.font = .pretendard(.semiBold, size: 16)
        
        self.layer.cornerRadius = 5
    }
}


