//
//  Routine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import SwiftData

@Model
final class Routine {
    var name: String
    var stamp: String
    var weightTraining: [WeightTraining]

    init(name: String = "", stamp: String = "", weightTraining: [WeightTraining] = []) {
        self.name = name
        self.stamp = stamp
        self.weightTraining = weightTraining
    }
}
