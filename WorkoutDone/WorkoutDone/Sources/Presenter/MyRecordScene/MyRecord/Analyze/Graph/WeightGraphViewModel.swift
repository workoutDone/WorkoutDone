//
//  WeightGraphViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/27.
//

import SwiftUI
import RealmSwift

class WeightGraphViewModel : ObservableObject {
    @Published var weightBodyInfo : [WorkOutDoneData] = []
    
    init() {
        
    }
    
//    func filterData() {
//        guard let dfRef = try? Realm() else { return }
//        let data = dfRef.objects(WorkOutDoneData.self)
//        self.weightBodyInfo = data.filter("bodyInfo.weight != 0")
//    }
}
//var dateArr: Results<DateInfo>!
//
// @IBAction func fetch(_ sender: Any) {
//        let realmData = try! Realm()
//
//        let dateInfo = realmData.objects(DateInfo.self).sorted(byKeyPath: "date", ascending: true).filter("bodyInfo.c != 0")
//        dateArr = dateInfo
//        for i in dateArr {
//            print("날짜: \(i.date)")
//            print("체중 :\(i.bodyInfo?.c)")
//        }
//    }
