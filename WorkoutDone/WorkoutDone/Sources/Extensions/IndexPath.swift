//
//  IndexPath.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/01.
//

import UIKit

extension IndexPath {
    var routineOrder : String {
        guard let order = UnicodeScalar(section + 65) else {
            return ""
        }
        return String(Character(order))
    }
}
