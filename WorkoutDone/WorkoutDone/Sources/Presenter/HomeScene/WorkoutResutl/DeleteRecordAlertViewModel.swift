//
//  DeleteRecordAlertViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/06.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa

class DeleteRecordAlertViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager3.shared
    var workOutDoneData : Results<WorkOutDoneData>?
    init(workOutDoneData: Results<WorkOutDoneData>? = nil) {
        self.workOutDoneData = realm.objects(WorkOutDoneData.self)
    }
    
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData?  {
        let workoutDoneData = RealmManager3.shared.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
    
    func deleteRoutineData(id : Int) {
        guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
        if let routine = workoutDoneData.routine {
            realmManager.deleteData(routine)
        }
    }
    func deleteWorkoutTimeData(id : Int) {
        guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
        try! realm.write {
            workoutDoneData.workOutTime = nil
        }
    }
    
    struct Input {
        let deleteTrigger : Driver<Void>
        let selectedDate : Driver<Int>
    }
    
    struct Output {
        let deleteRoutineData : Driver<Bool>
    }
    
    func transform(input: Input) -> Output {
        let deleteRoutineData = Driver<Bool>.combineLatest(input.selectedDate, input.deleteTrigger, resultSelector: { (id, _) in
            self.deleteRoutineData(id: id)
            self.deleteWorkoutTimeData(id: id)
            return true
        })
        return Output(deleteRoutineData: deleteRoutineData)
    }
}
