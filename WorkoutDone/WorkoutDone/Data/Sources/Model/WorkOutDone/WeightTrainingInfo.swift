//
//  WeightTrainingInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import SwiftData

@Model
public final class WeightTrainingInfo {
    public var setCount: Int
    public var weight: Double?
    public var trainingCount: Int?

    public init(setCount: Int, weight: Double? = nil, trainingCount: Int? = nil) {
        self.setCount = setCount
        self.weight = weight
        self.trainingCount = trainingCount
    }
}
