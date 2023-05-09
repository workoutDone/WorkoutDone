//
//  FatPercentageGraphViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/06.
//

import SwiftUI
import RealmSwift

class FatPercentageGraphViewModel : ObservableObject {
    let realm = try! Realm()
    @Published var fatPercentageData : [WorkOutDoneData] = []
    
    func readFatPercentageData() {
        let objects = realm.objects(WorkOutDoneData.self)
        fatPercentageData = Array(objects).sorted(by: { $0.date.yyMMddToDate() ?? Date() < $1.date.yyMMddToDate() ?? Date() })
    }
}
