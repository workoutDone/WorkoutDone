//
//  TemporaryRoutine.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/29.
//

import SwiftData

@Model
public final class TemporaryRoutine: IntIdentifiable {
    @Attribute(.unique) public var id: Int
    public var name: String
    public var stamp: String
    public var intDate: Int
    public var weightTraining: [WeightTraining]

    public init(
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
