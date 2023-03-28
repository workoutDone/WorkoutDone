//
//  BodyInfo.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import RealmSwift

class BodyInfo : Object {
    @Persisted dynamic var wegiht : Double?
    @Persisted dynamic var skeletalMuscleMass : Double?
    @Persisted dynamic var fatPercentage : Double?
}
