//
//  DuringEditRoutineViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/09.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class DuringEditRoutineViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
    struct Input {
        let loadView : Driver<Void>
        let weightTrainingArrayIndex : Driver<Int>
    }
    
    struct Output {
        let weightTraining : Driver<WeightTraining?>
    }
    
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func transform(input : Input) -> Output {
        
        let weightTraining = Driver<WeightTraining?>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (_, index) in
            let routine = self.readTemporaryRoutineData()
            let weightTrainingValue = routine?.weightTraining[index]
            return weightTrainingValue
        })
        
        return Output(weightTraining: weightTraining)
    }
}
