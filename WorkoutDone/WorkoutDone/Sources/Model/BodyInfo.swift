//
//  BodyInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import RealmSwift

class BodyInfo : Object {
    @Persisted dynamic var wegiht : Double = 0
    @Persisted dynamic var skeletalMuscleMass : Double = 0
    @Persisted dynamic var fatPercentage : Double = 0
    
    convenience init(wegiht: Double, skeletalMuscleMass: Double, fatPercentage: Double) {
        self.init()
        self.wegiht = wegiht
        self.skeletalMuscleMass = skeletalMuscleMass
        self.fatPercentage = fatPercentage
    }
}
