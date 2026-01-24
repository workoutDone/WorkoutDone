//
//  WeightGraphViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import SwiftData
import Data
import UIExtensions
import FoundationExtensions

class WeightGraphViewModel : ObservableObject {
    @Published var weightData : [WorkOutDoneData] = []
    
    func readWeightData() {
        let descriptor = FetchDescriptor<WorkOutDoneData>()
        let objects = (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
        weightData = objects
            .sorted(by: { $0.date.yyMMddToDate() ?? Date() < $1.date.yyMMddToDate() ?? Date() })
            .filter({
                $0.bodyInfo?.weight != nil && $0.bodyInfo?.weight ?? 0 >= 0
            })
    }
}
