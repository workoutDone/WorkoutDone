//
//  String.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/30.
//

import UIKit

extension String {
    func yyMMddToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
    func transformDate() -> String {
        let startIndex = index(startIndex, offsetBy: 2)
        let transformedDate = self[startIndex...]
        return String(transformedDate)
    }
}

