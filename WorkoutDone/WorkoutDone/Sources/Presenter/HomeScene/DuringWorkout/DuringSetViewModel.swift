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
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func deleteTemporaryRoutineData(infoArrayIndex : Int, arrayIndex : Int) {
        let temporaryRoutineData = readTemporaryRoutineData()
        if let weightTrainingInfo = temporaryRoutineData?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex] {
            realmManager.deleteData(weightTrainingInfo)
        }
    }
    
    func updateTemporaryRoutineSet(infoArrayIndex : Int, arrayIndex : Int) {
        let temporaryRoutineData = readTemporaryRoutineData()
        let weightTrainingInfoCount = temporaryRoutineData?.weightTraining[arrayIndex].weightTrainingInfo.count
        if let weightTrainingInfoArray = temporaryRoutineData?.weightTraining[arrayIndex].weightTrainingInfo {
            for (index, weightTrainingInfo) in weightTrainingInfoArray.enumerated() {
                do {
                    try realm.write {
                        weightTrainingInfo.setCount = index + 1
                    }
                }
                catch {
                    print(error)
                }
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
