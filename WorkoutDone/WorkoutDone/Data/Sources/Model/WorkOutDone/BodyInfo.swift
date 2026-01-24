//
//  BodyInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import SwiftData

@Model
public final class BodyInfo {
    public var weight: Double?
    public var skeletalMuscleMass: Double?
    public var fatPercentage: Double?

    public init(weight: Double? = nil, skeletalMuscleMass: Double? = nil, fatPercentage: Double? = nil) {
        self.weight = weight
        self.skeletalMuscleMass = skeletalMuscleMass
        self.fatPercentage = fatPercentage
    }
}
