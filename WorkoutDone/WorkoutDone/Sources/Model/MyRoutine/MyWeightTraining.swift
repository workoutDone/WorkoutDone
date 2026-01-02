//
//  MyWeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import SwiftData

@Model
final class MyWeightTraining {
    var myBodyPart: String
    var myWeightTraining: String

    init(myBodyPart: String = "", myWeightTraining: String = "") {
        self.myBodyPart = myBodyPart
        self.myWeightTraining = myWeightTraining
    }
}
