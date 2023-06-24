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
//        let weightTrainingName : Driver<String> //셀 구분할때
//        let weightTrainingInfoArrayCount : Driver<Int>
    }
    
    struct Output {
        let weightTrainingInfoCount : Driver<Int>
        let weightTrainingInfo : Driver<[WeightTrainingInfo]>
        let addData : Driver<Bool>
        
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
            print(routine?.weightTraining[index].weightTrainingInfo, routine?.weightTraining[index].weightTraining)
            return true
        })
        
        return Output(weightTrainingInfoCount: weightTrainingInfoCount,
                      weightTrainingInfo: weightTrainingInfo,
                      addData: addData)
    }
}
