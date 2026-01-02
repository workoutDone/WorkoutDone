//
//  DuringEditRoutineViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/09.
//

import UIKit
import RxCocoa
import RxSwift

class DuringEditRoutineViewModel {
    private let dataManager = SwiftDataManager.shared
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
    struct Input {
        let loadView : Driver<Void>
    }
    
    struct Output {
        let weightTraining : Driver<[WeightTraining]>
    }
    
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = dataManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func transform(input : Input) -> Output {
        
        let weightTraining = input.loadView.map { _ -> [WeightTraining] in
            let routine = self.readTemporaryRoutineData()
            let weightTrainingValue = routine?.weightTraining
            
            if let weightTrainingValue = weightTrainingValue {
                return weightTrainingValue
            }
            else {
                return []
            }
        }
        
        return Output(weightTraining: weightTraining)
    }
}
