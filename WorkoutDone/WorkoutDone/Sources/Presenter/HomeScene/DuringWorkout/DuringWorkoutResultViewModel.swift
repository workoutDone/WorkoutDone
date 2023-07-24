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

//제목이 있는지 없는지 확인하는 bool 타입 하나 만들기
//false 인 경우 label hidden
//3

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
        let hasRoutineTitle : Driver<Bool>
//        let routineBodyPartArray : Driver<[String]>
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
    
    func hasRoutineTitle(id: Int) -> Bool {
        let workoutData = self.readWorkoutDoneData(id: id)
        
        if workoutData?.routine?.name == "" {
            return false
        }
        else {
            return true
        }
    }
    func convertIntToTimeValue(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        return timeString
    }
    
    func sortBodyPart(id: Int) -> [String] {
        let workoutData = self.readWorkoutDoneData(id: id)
        guard let weightTraining = workoutData?.routine?.weightTraining else { return [] }
        let arrayWeightTraining = Array(weightTraining)
        
        let letterCounts = arrayWeightTraining.reduce(into: [:]) { counts, word in
            counts[word, default: 0] += 1
        }
        let sortedByCount = letterCounts.sorted { $0.value > $1.value }
        let result = Array(sortedByCount.prefix(3).map { $0.key .bodyPart})
        return result
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
                if routineTitle == "" {
                    return "고민"
                }
                else {
                    return routineTitle
                }
            }
            return ""
        })

        let deleteTemporaryRoutine = Driver<Bool>.combineLatest(input.loadView, input.homeButtonTrigger, resultSelector: { (_, _) in
            self.deleteTemporaryRoutineData()
            return true
        })

        let hasRoutineTitle = input.loadView.map({ value -> Bool in
            let temporaryRoutineData = self.readTemporaryRoutineData()
            let dateId = temporaryRoutineData?.intDate
            if self.hasRoutineTitle(id: dateId!) {
                return true
            }
            else {
                return false
            }
        })
        
        let routineBodyPartArray = input.loadView.map({ value -> [String] in
            let temporaryRoutineData = self.readTemporaryRoutineData()
            let dateId = temporaryRoutineData?.intDate
            let array = self.sortBodyPart(id: dateId!)
            
            return array
        })
        
        
        return Output(
            routineData: routineData,
            workoutTimeData: workoutTimeData,
            routineTitle: routineTitle,
            deleteTemporaryRoutine: deleteTemporaryRoutine,
            hasRoutineTitle: hasRoutineTitle)
    }
}
