//
//  WeightGraphViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import RealmSwift

class WeightGraphViewModel : ObservableObject {
    let realm = try! Realm()
    @Published var weightData : [WorkOutDoneData] = []
    
    func readWeightData() {
        let objects = realm.objects(WorkOutDoneData.self)
        weightData = Array(objects)
            .sorted(by: { $0.date.yyMMddToDate() ?? Date() < $1.date.yyMMddToDate() ?? Date() })
            .filter({
                $0.bodyInfo?.weight != nil && $0.bodyInfo?.weight ?? 0 >= 0
            })
    }
}
