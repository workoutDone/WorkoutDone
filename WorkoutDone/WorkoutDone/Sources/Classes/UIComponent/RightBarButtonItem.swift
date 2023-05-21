//
//  RightBarButtonItem.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/21.
//

import UIKit
import SnapKit
import Then

class RightBarButtonItem : UIButton {
    //MARK: - Properties
    let title : String
    let buttonBackgroundColor : UIColor
    let titleColor : UIColor
    
    init(title: String, buttonBackgroundColor: UIColor, titleColor : UIColor) {
        self.title = title
        self.buttonBackgroundColor = buttonBackgroundColor
        self.titleColor = titleColor
        
        super.init(frame: .zero)
        setUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUI() {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)

        titleLabel?.font = .pretendard(.semiBold, size: 16)
        backgroundColor = buttonBackgroundColor
    }
}
