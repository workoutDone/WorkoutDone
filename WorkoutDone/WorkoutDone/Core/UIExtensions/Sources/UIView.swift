//
//  UIView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/18.
//

import UIKit

public extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
