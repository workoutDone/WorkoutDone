//
//  UIStackView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/18.
//

import UIKit

public extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
