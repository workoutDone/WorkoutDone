//
//  MyWeightTraining.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import SwiftData

@Model
public final class MyWeightTraining {
    public var myBodyPart: String
    public var myWeightTraining: String

    public init(myBodyPart: String = "", myWeightTraining: String = "") {
        self.myBodyPart = myBodyPart
        self.myWeightTraining = myWeightTraining
    }
}
