//
//  WeightTrainingInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/12.
//

import Foundation
import RealmSwift

class WeightTrainingInfo : Object {
    @Persisted dynamic var setCount : Int
    @Persisted dynamic var weight : Int?
    @Persisted dynamic var trainingCount : Int?
    
    convenience init(setCount: Int, weight: Int, trainingCount: Int) {
        self.init()
        self.setCount = setCount
        self.weight = weight
        self.trainingCount = trainingCount
    }
    
    convenience init(setCount: Int, trainingCount: Int) {
        self.init()
        self.setCount = setCount
        self.trainingCount = trainingCount
    }
}

