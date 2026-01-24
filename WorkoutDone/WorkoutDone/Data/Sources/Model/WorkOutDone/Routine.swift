//
//  Routine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import SwiftData

@Model
public final class Routine {
    public var name: String
    public var stamp: String
    public var weightTraining: [WeightTraining]

    public init(name: String = "", stamp: String = "", weightTraining: [WeightTraining] = []) {
        self.name = name
        self.stamp = stamp
        self.weightTraining = weightTraining
    }
}
