//
//  FatPercentageGraphViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/06.
//

import SwiftUI
import SwiftData
import Data
import UIExtensions
import FoundationExtensions

class FatPercentageGraphViewModel : ObservableObject {
    @Published var fatPercentageData : [WorkOutDoneData] = []
    
    func readFatPercentageData() {
        let descriptor = FetchDescriptor<WorkOutDoneData>()
        let objects = (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
        fatPercentageData = objects
            .sorted(by: { $0.date.yyMMddToDate() ?? Date() < $1.date.yyMMddToDate() ?? Date() })
            .filter({
                $0.bodyInfo?.fatPercentage != nil && $0.bodyInfo?.fatPercentage ?? 0 >= 0
            })
    }
}
