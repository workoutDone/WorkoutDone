//
//  BodyPart.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import RealmSwift

class BodyPart : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var weightTraining: List<WeightTraining>

    convenience init(name: String, weightTraining: List<WeightTraining>) {
        self.init()
        self.name = name
        self.weightTraining = weightTraining
    }
}
