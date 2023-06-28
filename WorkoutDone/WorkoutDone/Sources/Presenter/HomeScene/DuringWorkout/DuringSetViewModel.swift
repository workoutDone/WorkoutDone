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
    let realmManager = RealmManager.shared
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
    struct Input {
        let loadView : Driver<Void>
        let weightTrainingArrayIndex : Driver<Int>
        let addWeightTrainingInfoTrigger : Driver<Void>
        let addWeightTrainingInfoIndexTrigger : Driver<Int>
        let deleteSetTrigger : Driver<Void>
        let deleteSetIndex : Driver<Int>
    }
    
    struct Output {
        let weightTrainingInfoCount : Driver<Int>
        let weightTrainingInfo : Driver<[WeightTrainingInfo]>
        let addData : Driver<Bool> 
        let weightTraining : Driver<WeightTraining?>
        let deleteSetData : Driver<Bool>
    }
    
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func transform(input : Input) -> Output {
        

        let weightTrainingInfoCount = Driver<Int>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (load, index) in
            let routine = self.readTemporaryRoutineData()
            let count = routine?.weightTraining[index].weightTrainingInfo.count ?? 0
            return count
        })
        let weightTrainingInfo = Driver<[WeightTrainingInfo]>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (_, index) in
            let routine = self.readTemporaryRoutineData()

            guard let info = routine?.weightTraining[index].weightTrainingInfo else {
                return []
            }
            
            return Array(info)
        })

        
        let addData = Driver<Bool>.zip( input.addWeightTrainingInfoTrigger, input.addWeightTrainingInfoIndexTrigger,  resultSelector: { (_, index) in
            let routine = self.readTemporaryRoutineData()
            let count = routine?.weightTraining[index].weightTrainingInfo.count
            do {
                try self.realm.write {
                    let weightTrainingInfo = WeightTrainingInfo()
                    weightTrainingInfo.setCount = (count ?? 0)  + 1
                    weightTrainingInfo.trainingCount = nil
                    weightTrainingInfo.weight = nil
                    routine?.weightTraining[index].weightTrainingInfo.append(weightTrainingInfo)
                }
            } catch {
                print("Error saving new items, \(error)")
            }
            return true
        })
        let weightTraining = Driver<WeightTraining?>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (_, index) in
            let routine = self.readTemporaryRoutineData()
//            guard let wegihtTrainingValue = routine?.weightTraining[index] else { WeightTraining(bodyPart: "", weightTraining: "") }
            let weightTrainingValue = routine?.weightTraining[index]
            return weightTrainingValue
        })
        
        let deleteSetData = Driver<Bool>.combineLatest(input.deleteSetTrigger, input.deleteSetIndex, input.weightTrainingArrayIndex, resultSelector: { (_, setIndex, arrayIndex) in
            let routine = self.readTemporaryRoutineData()
            
            let weightTrainingInfoValue = routine?.weightTraining[arrayIndex].weightTrainingInfo[setIndex]
            
//            routine?.weightTraining[arrayIndex].weightTrainingInfo.remove(at: setIndex)
    
//            self.realm.delete(weightTrainingInfoValue!)
            routine?.weightTraining[arrayIndex].weightTrainingInfo.realm?.delete((routine?.weightTraining[arrayIndex].weightTrainingInfo[setIndex])!)
            print(routine?.weightTraining, "확인용!")
            return true
        })
        
        return Output(weightTrainingInfoCount: weightTrainingInfoCount,
                      weightTrainingInfo: weightTrainingInfo,
                      addData: addData,
                      weightTraining: weightTraining,
                      deleteSetData: deleteSetData)
    }
}
