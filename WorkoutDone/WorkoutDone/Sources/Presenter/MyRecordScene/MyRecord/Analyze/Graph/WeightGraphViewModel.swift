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
    }
}
