//
//  DuringSetViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/23.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class DuringSetViewModel {
    let realm = try! Realm()
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
    struct Input {
        let loadView : Driver<Void>
        let weightTrainingArrayIndex : Driver<Int>
        let addWeightTrainingInfoTrigger : Driver<Void>
        let addWightTrainingInfoIndexTrigger : Driver<Int>
    }
    
    struct Output {
        let weightTrainingInfoCount : Driver<Int>
        let weightTrainingInfo : Driver<[WeightTrainingInfo]>
        let addData : Driver<Bool>
        let weightTraining : Driver<WeightTraining?>
    }
    func transform(input : Input) -> Output {
        

        let weightTrainingInfoCount = Driver<Int>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (load, index) in
            let routine = self.duringWorkoutRoutine.routine
            let count = routine?.weightTraining[index].weightTrainingInfo.count ?? 0
            return count
        })
        let weightTrainingInfo = Driver<[WeightTrainingInfo]>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (_, index) in
            let routine = self.duringWorkoutRoutine.routine

            guard let info = routine?.weightTraining[index].weightTrainingInfo else {
                return []
            }
            
            return Array(info)
        })

        
        let addData = Driver<Bool>.zip( input.addWeightTrainingInfoTrigger, input.addWightTrainingInfoIndexTrigger,  resultSelector: { (_, index) in
            let routine = self.duringWorkoutRoutine.routine
            let count = routine?.weightTraining[index].weightTrainingInfo.count
            
            routine?.weightTraining[index].weightTrainingInfo.append(objectsIn: [WeightTrainingInfo(setCount: (count ?? 0) + 1, weight: 0, trainingCount: 0)])
//            routine?.weightTraining[index].
            print(routine?.weightTraining)
            return true
        })
        let weightTraining = Driver<WeightTraining?>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (_, index) in
            let routine = self.duringWorkoutRoutine.routine
//            guard let wegihtTrainingValue = routine?.weightTraining[index] else { WeightTraining(bodyPart: "", weightTraining: "") }
            let weightTrainingValue = routine?.weightTraining[index]
            return weightTrainingValue
        })
        
        return Output(weightTrainingInfoCount: weightTrainingInfoCount,
                      weightTrainingInfo: weightTrainingInfo,
                      addData: addData,
                      weightTraining: weightTraining)
    }
}
