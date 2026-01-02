//
//  BodyInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import SwiftData

@Model
final class BodyInfo {
    var weight: Double?
    var skeletalMuscleMass: Double?
    var fatPercentage: Double?

    init(weight: Double? = nil, skeletalMuscleMass: Double? = nil, fatPercentage: Double? = nil) {
        self.weight = weight
        self.skeletalMuscleMass = skeletalMuscleMass
        self.fatPercentage = fatPercentage
    }
}
