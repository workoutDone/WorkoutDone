//
//  DuringWorkoutResultViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/29.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class DuringWorkoutResultViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared

    struct Input {
        let loadView : Driver<Void>
        let homeButtonTrigger : Driver<Void>
    }
    struct Output {
        let routineData : Driver<Routine?>
        let workoutTimeData : Driver<String>
        let routineTitle : Driver<String>
        let deleteTemporaryRoutine : Driver<Bool>
    }

    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }

    func deleteTemporaryRoutineData() {
        guard let temporaryRoutineData = readTemporaryRoutineData() else { return }
        realmManager.deleteData(temporaryRoutineData)
    }
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData?  {
        let workoutDoneData = RealmManager.shared.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
    func convertIntToTimeValue(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        return timeString
    }
    func transform(input : Input) -> Output {
        let routineData = input.loadView.map { _ -> Routine? in
            let temporaryRoutineData = self.readTemporaryRoutineData()
            let dateId = temporaryRoutineData?.intDate
            let workoutDoneData = self.readWorkoutDoneData(id: dateId!)
            return workoutDoneData?.routine
        }

        let workoutTimeData = input.loadView.map({ value -> String in
            let temporaryRoutineData = self.readTemporaryRoutineData()
            guard let dateId = temporaryRoutineData?.intDate else { return "" }
            let workoutDoneData = self.readWorkoutDoneData(id: dateId)
            let workoutTime = workoutDoneData?.workOutTime
            if let workoutTime = workoutTime {
                let stringWorkoutTimeValue = self.convertIntToTimeValue(workoutTime)
                return stringWorkoutTimeValue
            }
            else {
                return "00:00:00"
            }
        })
        
        let routineTitle = input.loadView.map({ value -> String in
            let temporaryRoutineData = self.readTemporaryRoutineData()
            guard let dateId = temporaryRoutineData?.intDate else { return "" }
            let workoutDoneData = self.readWorkoutDoneData(id: dateId)
            if let routineTitle = workoutDoneData?.routine?.name {
                return routineTitle
            }
            else {
                return "?? 고민좀"
            }
        })

        let deleteTemporaryRoutine = Driver<Bool>.combineLatest(input.loadView, input.homeButtonTrigger, resultSelector: { (_, _) in
            self.deleteTemporaryRoutineData()
            return true
        })
        return Output(
            routineData: routineData,
            workoutTimeData: workoutTimeData,
            routineTitle: routineTitle,
            deleteTemporaryRoutine: deleteTemporaryRoutine)
    }
}
