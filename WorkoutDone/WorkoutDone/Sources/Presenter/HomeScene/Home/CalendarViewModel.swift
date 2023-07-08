//
//  CalendarViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/07/08.
//

import Foundation
import RealmSwift

struct CalendarViewModel {
    func loadStampImage(date: String) -> [String: String] {
        let realm = try! Realm()
        
        let workOutDoneData : [WorkOutDoneData] = realm.objects(WorkOutDoneData.self).sorted(byKeyPath: "date", ascending: false).filter("date CONTAINS %@", date).compactMap{$0}
        var dayStamp = [String: String]()
        
        for workOutDone in workOutDoneData {
            if let day = workOutDone.date.yyMMddToDate()?.dToString(), let stamp = workOutDone.routine?.stamp {
                if stamp == "" {
                    dayStamp[day] = "stampVImage"
                } else {
                    dayStamp[day] = stamp
                }
            }
        }
        
        return dayStamp
    }
}
