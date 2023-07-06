//
//  Double.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/15.
//

import UIKit

extension Double {
    func truncateDecimalPoint() -> String {
        return String(format: "%.1f", self)
    }
}
