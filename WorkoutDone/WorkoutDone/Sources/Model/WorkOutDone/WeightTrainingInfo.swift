//
//  WeightTrainingInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import SwiftData

@Model
final class WeightTrainingInfo {
    var setCount: Int
    var weight: Double?
    var trainingCount: Int?

    init(setCount: Int, weight: Double? = nil, trainingCount: Int? = nil) {
        self.setCount = setCount
        self.weight = weight
        self.trainingCount = trainingCount
    }
}
