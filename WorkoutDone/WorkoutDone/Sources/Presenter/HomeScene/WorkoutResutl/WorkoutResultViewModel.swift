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
        let loadworkoutTimeData : Driver<Int>
//        let loadRoutineData : Driver<Routine>
    }
    
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData? {
        let workoutDoneData = realmManager.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
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
        let workoutTimeData = Driver<Int>.combineLatest(input.loadView, input.selectedData, resultSelector: { (_, id) in
            let workoutTimeData = self.readWorkoutDoneData(id: id)?.workOutTime
            return workoutTimeData ?? 0
        })
        
        return Output(
            hasData: hadData,
            loadworkoutTimeData: workoutTimeData)
    }
}
