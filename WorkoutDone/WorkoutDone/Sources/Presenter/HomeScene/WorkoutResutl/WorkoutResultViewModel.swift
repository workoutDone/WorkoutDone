//
//  WorkoutResultViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/13.
//

import RxSwift
import RxCocoa
import RealmSwift

class WorkoutResultViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    var workOutDoneData : Results<WorkOutDoneData>?
    init(workOutDoneData: Results<WorkOutDoneData>? = nil) {
        self.workOutDoneData = realm.objects(WorkOutDoneData.self)
    
    }
    
    struct Input {
        let loadView : Driver<Void>
        let selectedData : Driver<Int>
    }
    struct Output {
        let hasData : Driver<Bool>
        let workoutTimeData : Driver<String>
        let routineTitleData : Driver<String>
        let routineData : Driver<Routine?>
    }
    
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData? {
        let workoutDoneData = realmManager.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
    
    func convertIntToTimeValue(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        return timeString
    }
    
    func transform(input: Input) -> Output {
        let hadData = Driver<Bool>.combineLatest(input.loadView, input.selectedData, resultSelector: { (_, id) in
            let workoutTimeData = self.readWorkoutDoneData(id: id)?.workOutTime
            let routineData = self.readWorkoutDoneData(id: id)?.routine
            if workoutTimeData == nil && routineData == nil {
                return false
            }
            else {
                return true
            }
        })
        let workoutTimeData = Driver<String>.combineLatest(input.loadView, input.selectedData, resultSelector: { (_, date) in
           let dateId = date
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
        
        let routineTitleData = Driver<String>.combineLatest(input.loadView, input.selectedData, resultSelector: { (_, date) in
            let dateId = date
            let workoutDoneData = self.readWorkoutDoneData(id: dateId)
            let routineTitle = workoutDoneData?.routine?.name
            
            if let routineTitle = routineTitle {
                return routineTitle
            }
            else {
                return "고민중!"
            }
        })
        
        let routineData = Driver<Routine?>.combineLatest(input.loadView, input.selectedData, resultSelector: { (_, date) in
            let dateId = date
            let workoutDoneData = self.readWorkoutDoneData(id: dateId)
            
            return workoutDoneData?.routine
        })
        
        return Output(
            hasData: hadData,
            workoutTimeData: workoutTimeData,
            routineTitleData: routineTitleData,
            routineData: routineData)
    }
}
