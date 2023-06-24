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
        let weightTraingingArrayIndex : Driver<Int>
    }
    
    struct Output {
        let weightTrainingInfoCount : Driver<Int>
        
    }
    func transform(input : Input) -> Output {
        

        let weightTrainingInfoCount = Driver<Int>.combineLatest(input.loadView, input.weightTraingingArrayIndex, resultSelector: { (load, index) in
            let routine = self.duringWorkoutRoutine.routine
            let count = routine?.weightTraining[index].weightTrainingInfo.count ?? 0
            return count
        })
        
<<<<<<< HEAD
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
            return true
        })
        
        return Output(weightTrainingInfoCount: weightTrainingInfoCount,
                      weightTrainingInfo: weightTrainingInfo,
                      addData: addData)
=======
        return Output(weightTrainingInfoCount: weightTrainingInfoCount)
>>>>>>> parent of 8306a47 (운동 세트 추가 구현)
    }
}
