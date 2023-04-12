//
//  SkeletalMuslemassViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/06.
//

import SwiftUI
import RealmSwift

class SkeletalMuslemassGraphViewModel : ObservableObject {
    let realm = try! Realm()
    @Published var skeletalMusleMassData : [WorkOutDoneData] = []
    
    func readSkeletalMusleMassData() {
        let objects = realm.objects(WorkOutDoneData.self)
        skeletalMusleMassData = Array(objects)
    }
}
