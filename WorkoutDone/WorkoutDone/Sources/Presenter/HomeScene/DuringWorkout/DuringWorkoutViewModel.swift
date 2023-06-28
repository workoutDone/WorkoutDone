//
//  DuringWorkoutViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/23.
//

import UIKit
import RealmSwift
import RxCocoa
import RxSwift

class DuringWorkoutViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    struct Input {
        let loadView : Driver<Void>
        let weightTrainingArrayIndex  : Driver<Int>
    }
    struct Output {
        let totalWorkoutCount : Driver<Double>
        let weightTrainingArrayCount : Driver<Int>
        let currentWorkoutBodyPart : Driver<String>
        let currentWorkoutName : Driver<String>
    }
    
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    
    func transtorm(input : Input) -> Output {

        let totalWorkoutCount = input.loadView.map {
            let routine = self.readTemporaryRoutineData()
            let count = Double(routine?.weightTraining.count ?? 0)
            return count
        }
        let weightTrainingArrayCount = input.loadView.map {
            let routine = self.readTemporaryRoutineData()
            let count = Int(routine?.weightTraining.count ?? 0)
            return count
        }

        let currentWorkoutBodyPart = Driver<String>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (load, index) in
            let routine = self.readTemporaryRoutineData()
            let bodyPart = routine?.weightTraining[index].bodyPart ?? ""
            return bodyPart
        })
        let currentWorkoutName = Driver<String>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (load, index) in
            let routine = self.readTemporaryRoutineData()
            let workoutName = routine?.weightTraining[index].weightTraining ?? ""
            return workoutName
        })
        
        return Output(totalWorkoutCount: totalWorkoutCount,
                      weightTrainingArrayCount: weightTrainingArrayCount,
                      currentWorkoutBodyPart: currentWorkoutBodyPart, currentWorkoutName: currentWorkoutName)
    }
}
