//
//  Date.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/30.
//

import UIKit

extension Date {
    func yyMMddToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
}
