//
//  WeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import SwiftData

@Model
final class WeightTraining {
    var bodyPart: String
    var weightTraining: String
    var weightTrainingInfo: [WeightTrainingInfo]

    init(bodyPart: String = "", weightTraining: String = "", weightTrainingInfo: [WeightTrainingInfo] = []) {
        self.bodyPart = bodyPart
        self.weightTraining = weightTraining
        self.weightTrainingInfo = weightTrainingInfo
    }
}
