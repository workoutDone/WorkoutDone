//
//  WeightGraphViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import RealmSwift


class WeightGraphViewModel : ObservableObject {
    @Published var workoutDoneData : [WorkOutDoneData] = []
    

    func readWeightData() {
        let realm = try! Realm()
        let objects = realm.objects(WorkOutDoneData.self)
        workoutDoneData = Array(objects)
        print(workoutDoneData)
        print("데이터")
    }

}
