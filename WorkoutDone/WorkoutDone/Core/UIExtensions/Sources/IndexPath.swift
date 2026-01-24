//
//  IndexPath.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/01.
//

import UIKit

public extension IndexPath {
    var routineOrder : String {
        guard let order = UnicodeScalar(section + 65) else {
            return ""
        }
        return String(Character(order))
    }
}
