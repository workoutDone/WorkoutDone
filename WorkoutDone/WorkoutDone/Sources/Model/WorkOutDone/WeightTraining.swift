//
//  WeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import RealmSwift

class WeightTraining : Object {
    @Persisted dynamic var bodyPart : String
    @Persisted dynamic var weightTraining : String
    @Persisted dynamic var weightTrainingInfo : List<WeightTrainingInfo>
    
    convenience init(bodyPart: String, weightTraining: String, weightTrainingInfo: List<WeightTrainingInfo>) {
        self.init()
        self.bodyPart = bodyPart
        self.weightTraining = weightTraining
        self.weightTrainingInfo = weightTrainingInfo
    }
    
    convenience init(bodyPart: String, weightTraining: String) {
        self.init()
        self.bodyPart = bodyPart
        self.weightTraining = weightTraining
    }
}
