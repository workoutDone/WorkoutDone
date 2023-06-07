//
//  MyRoutine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class MyRoutine : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var stamp : String
    @Persisted dynamic var myWeightTraining: List<MyWeightTraining>

    convenience init(name: String, stamp: String, myWeightTraining: List<MyWeightTraining>) {
        self.init()
        self.name = name
        self.stamp = stamp
        self.myWeightTraining = myWeightTraining
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
