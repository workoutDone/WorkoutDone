//
//  TemporaryRoutine.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/29.
//

import SwiftData

@Model
final class TemporaryRoutine: IntIdentifiable {
    @Attribute(.unique) var id: Int
    var name: String
    var stamp: String
    var intDate: Int
    var weightTraining: [WeightTraining]

    init(
        id: Int = 0,
        name: String = "",
        stamp: String = "",
        intDate: Int,
        weightTraining: [WeightTraining] = []
    ) {
        self.id = id
        self.name = name
        self.stamp = stamp
        self.intDate = intDate
        self.weightTraining = weightTraining
    }
}
