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
    @Persisted dynamic var intDate : Int
    @Persisted dynamic var weightTraining : List<WeightTraining>

    convenience init(name: String, stamp: String, intDate: Int ,weightTraining: List<WeightTraining>) {
        self.init()
        self.name = name
        self.stamp = stamp
        self.intDate = intDate
        self.weightTraining = weightTraining
    }
    override class func primaryKey() -> String? {
        return "id"
    }
}
