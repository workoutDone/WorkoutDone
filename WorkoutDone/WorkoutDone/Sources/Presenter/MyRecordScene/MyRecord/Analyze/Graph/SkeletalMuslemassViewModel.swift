//
//  SkeletalMuslemassViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/06.
//

import SwiftUI
import SwiftData
import Data
import UIExtensions
import FoundationExtensions

class SkeletalMuslemassGraphViewModel : ObservableObject {
    @Published var skeletalMusleMassData : [WorkOutDoneData] = []
    
    func readSkeletalMusleMassData() {
        let descriptor = FetchDescriptor<WorkOutDoneData>()
        let objects = (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
        skeletalMusleMassData = objects
            .sorted(by: { $0.date.yyMMddToDate() ?? Date() < $1.date.yyMMddToDate() ?? Date() })
            .filter({
                $0.bodyInfo?.skeletalMuscleMass != nil && $0.bodyInfo?.skeletalMuscleMass ?? 0 >= 0
            })
    }
}
