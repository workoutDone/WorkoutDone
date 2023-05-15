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
        skeletalMusleMassData = Array(objects).sorted(by: { $0.date.yyMMddToDate() ?? Date() < $1.date.yyMMddToDate() ?? Date() })
            .filter({
                $0.bodyInfo?.skeletalMuscleMass != nil && $0.bodyInfo?.skeletalMuscleMass ?? 0 >= 0
            })
//            .map {
//                let startIndex = $0.date.index($0.date.startIndex, offsetBy: 2)
//                let transformDate = $0.date[startIndex...]
//                return WorkOutDoneData(id: $0.id, date: String(transformDate))
//            }
    }
}
