//
//  WeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import RealmSwift

class WeightTraining : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var weightTrainingInfo : List<WeightTrainingInfo>
    
    convenience init(name: String, weightTrainingInfo: List<WeightTrainingInfo>) {
        self.init()
        self.name = name
        self.weightTrainingInfo = weightTrainingInfo
    }
}
