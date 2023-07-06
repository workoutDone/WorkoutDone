//
//  Routine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class Routine : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var stamp : String
    @Persisted dynamic var weightTraining : List<WeightTraining>

    convenience init(name: String, stamp: String, weightTraining: List<WeightTraining>) {
        self.init()
        self.name = name
        self.stamp = stamp
        self.weightTraining = weightTraining
    }
}
