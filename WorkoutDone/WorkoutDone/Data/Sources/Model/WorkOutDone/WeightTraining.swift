//
//  WeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import SwiftData

@Model
public final class WeightTraining {
    public var bodyPart: String
    public var weightTraining: String
    public var weightTrainingInfo: [WeightTrainingInfo]

    public init(bodyPart: String = "", weightTraining: String = "", weightTrainingInfo: [WeightTrainingInfo] = []) {
        self.bodyPart = bodyPart
        self.weightTraining = weightTraining
        self.weightTrainingInfo = weightTrainingInfo
    }
}
