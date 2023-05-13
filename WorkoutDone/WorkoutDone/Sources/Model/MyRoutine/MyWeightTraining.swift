//
//  MyWeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class MyWeightTraining : Object {
    @Persisted dynamic var name : String
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
