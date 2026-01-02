//
//  DuringSetViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/23.
//

import UIKit
import RxCocoa
import RxSwift

class DuringSetViewModel {
    private let dataManager = SwiftDataManager.shared
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
    struct Input {
        let loadView : Driver<Void>
        let weightTrainingArrayIndex : Driver<Int>
        let addWeightTrainingInfoTrigger : Driver<Void>
        let addWeightTrainingInfoIndexTrigger : Driver<Int>
        let deleteSetTrigger : Driver<Void>
        let deleteSetIndex : Driver<Int>
        let deleteWeightTrainingArrayIndex : Driver<Int>
    }
    
    struct Output {
        let weightTrainingInfoCount : Driver<Int>
        let weightTrainingInfo : Driver<[WeightTrainingInfo]>
        let addData : Driver<Bool> 
        let weightTraining : Driver<WeightTraining?>
        let deleteSetData : Driver<Bool>
    }
    
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = dataManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func deleteTemporaryRoutineData(infoArrayIndex : Int, arrayIndex : Int) {
        guard let temporaryRoutineData = readTemporaryRoutineData() else { return }
        dataManager.updateData(data: temporaryRoutineData) { updatedRoutine in
            guard updatedRoutine.weightTraining.indices.contains(arrayIndex) else { return }
            guard updatedRoutine.weightTraining[arrayIndex].weightTrainingInfo.indices.contains(infoArrayIndex) else { return }
            updatedRoutine.weightTraining[arrayIndex].weightTrainingInfo.remove(at: infoArrayIndex)
        }
    }
    
    func updateTemporaryRoutineSet(infoArrayIndex : Int, arrayIndex : Int) {
        guard let temporaryRoutineData = readTemporaryRoutineData() else { return }
        dataManager.updateData(data: temporaryRoutineData) { updatedRoutine in
            guard updatedRoutine.weightTraining.indices.contains(arrayIndex) else { return }
            for (index, weightTrainingInfo) in updatedRoutine.weightTraining[arrayIndex].weightTrainingInfo.enumerated() {
                weightTrainingInfo.setCount = index + 1
            }
        }
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
            if let routine = routine {
                self.dataManager.updateData(data: routine) { updatedRoutine in
                    guard updatedRoutine.weightTraining.indices.contains(index) else { return }
                    let weightTrainingInfo = WeightTrainingInfo(setCount: (count ?? 0) + 1)
                    updatedRoutine.weightTraining[index].weightTrainingInfo.append(weightTrainingInfo)
                }
            }
            return true
        })
        let weightTraining = Driver<WeightTraining?>.combineLatest(input.loadView, input.weightTrainingArrayIndex, resultSelector: { (_, index) in
            let routine = self.readTemporaryRoutineData()
            let weightTrainingValue = routine?.weightTraining[index]
            return weightTrainingValue
        })
        
        let deleteSetData = Driver<Bool>.zip(input.deleteSetTrigger, input.deleteSetIndex, input.deleteWeightTrainingArrayIndex, resultSelector: { (_, setIndex, arrayIndex) in
            self.deleteTemporaryRoutineData(infoArrayIndex: setIndex, arrayIndex: arrayIndex)
            self.updateTemporaryRoutineSet(infoArrayIndex: setIndex, arrayIndex: arrayIndex)
            return true
        })
        
        return Output(weightTrainingInfoCount: weightTrainingInfoCount,
                      weightTrainingInfo: weightTrainingInfo,
                      addData: addData,
                      weightTraining: weightTraining,
                      deleteSetData: deleteSetData)
    }
}
