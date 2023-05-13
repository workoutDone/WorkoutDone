//
//  MyBodyPart.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class MyBodyPart : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var myWeightTraining: List<MyWeightTraining>

    convenience init(name: String, myWeightTraining: List<MyWeightTraining>) {
        self.init()
        self.name = name
        self.myWeightTraining = myWeightTraining
    }
}
