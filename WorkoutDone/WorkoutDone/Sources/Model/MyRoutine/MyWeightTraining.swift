//
//  MyWeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class MyWeightTraining : Object {
    @Persisted dynamic var myBodyPart : String
    @Persisted dynamic var myWeightTraining : String
    
    convenience init(myBodyPart: String, myWeightTraining: String) {
        self.init()
        self.myBodyPart = myBodyPart
        self.myWeightTraining = myWeightTraining
    }
}
