//
//  TemporaryRoutine.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/29.
//

import RealmSwift

class TemporaryRoutine : Object {
    @Persisted dynamic var id : Int = 0
    @Persisted dynamic var name : String
    @Persisted dynamic var stamp : String
    @Persisted dynamic var weightTraining : List<WeightTraining>

    convenience init(name: String, stamp: String, weightTraining: List<WeightTraining>) {
        self.init()
        self.name = name
        self.stamp = stamp
        self.weightTraining = weightTraining
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}
