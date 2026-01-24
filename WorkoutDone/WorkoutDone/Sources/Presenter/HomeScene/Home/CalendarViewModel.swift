//
//  CalendarViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/07/08.
//

import Foundation
import SwiftData
import Data
import FoundationExtensions

struct CalendarViewModel {
    func loadStampImage(date: String) -> [String: String] {
        let predicate = #Predicate<WorkOutDoneData> { $0.date.contains(date) }
        let sortByDate = [SortDescriptor(\WorkOutDoneData.date, order: .reverse)]
        let descriptor = FetchDescriptor<WorkOutDoneData>(predicate: predicate, sortBy: sortByDate)
        let workOutDoneData: [WorkOutDoneData] = (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
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
