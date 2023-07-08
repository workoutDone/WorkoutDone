//
//  Date.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/30.
//

import UIKit

extension Date {
    func dToString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return dateFormatter.string(from: self)
    }
    
    func yyMMddToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy.MM.dd"
        return dateFormatter.string(from: self)
    }
    func yyyyMMddToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: self)
    }
    func dateToInt() -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let intDateFormatter = dateFormatter.string(from: self)
        guard let data = Int(intDateFormatter) else { return 0 }
        return data
    }
    func MToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월"
        return dateFormatter.string(from: self)
    }
    func yyyyMMToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월"
        return dateFormatter.string(from: self)
    }
}
