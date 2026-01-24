//
//  MyRoutine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import SwiftData

@Model
public final class MyRoutine: StringIdentifiable {
    @Attribute(.unique) public var id: String
    public var name: String
    public var stamp: String
    public var myWeightTraining: [MyWeightTraining]

    public init(id: String = UUID().uuidString, name: String = "", stamp: String = "", myWeightTraining: [MyWeightTraining] = []) {
        self.id = id
        self.name = name
        self.stamp = stamp
        self.myWeightTraining = myWeightTraining
    }
}
