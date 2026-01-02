//
//  DeleteRecordAlertViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/06.
//

import UIKit
import RxSwift
import RxCocoa

class DeleteRecordAlertViewModel {
    private let dataManager = SwiftDataManager.shared
    
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData?  {
        let workoutDoneData = dataManager.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
    
    func deleteRoutineData(id : Int) {
        guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
        if let routine = workoutDoneData.routine {
            dataManager.deleteData(data: routine)
        }
    }
    func deleteWorkoutTimeData(id : Int) {
        guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
        dataManager.updateData(data: workoutDoneData) { updatedData in
            updatedData.workOutTime = nil
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
