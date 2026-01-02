//
//  MyRoutine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import SwiftData

@Model
final class MyRoutine: StringIdentifiable {
    @Attribute(.unique) var id: String
    var name: String
    var stamp: String
    var myWeightTraining: [MyWeightTraining]

    init(id: String = UUID().uuidString, name: String = "", stamp: String = "", myWeightTraining: [MyWeightTraining] = []) {
        self.id = id
        self.name = name
        self.stamp = stamp
        self.myWeightTraining = myWeightTraining
    }
}
