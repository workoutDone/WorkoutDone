//
//  RoutineViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/02.
//

import UIKit
import SwiftData
import Data
import UIExtensions

struct RoutineViewModel {
    func loadMyRoutine() -> [MyRoutine] {
        let descriptor = FetchDescriptor<MyRoutine>()
        return (try? SwiftDataManager.shared.context.fetch(descriptor)) ?? []
    }
    
    func loadMyRoutineName(id: String) -> String {
        guard let myRoutine = SwiftDataManager.shared.readData(id: id, type: MyRoutine.self) else {
            return ""
        }
        
        let myRoutineName = myRoutine.name
        
        return myRoutineName
    }
    
    func loadMyRoutineStamp(id: String) -> String {
        guard let myRoutine = SwiftDataManager.shared.readData(id: id, type: MyRoutine.self) else {
            return ""
        }
        
        let myRoutineStamp = myRoutine.stamp
        
        return myRoutineStamp 
    }
    
    func saveMyRoutine(id: String?, name: String, stamp: String, weightTraining: [MyWeightTraining]) {
        if let id = id, let existingMyRoutine = SwiftDataManager.shared.readData(id: id, type: MyRoutine.self) {
            SwiftDataManager.shared.updateData(data: existingMyRoutine) { updatedRoutine in
                updatedRoutine.name = name
                updatedRoutine.stamp = stamp
                updatedRoutine.myWeightTraining.removeAll()
                updatedRoutine.myWeightTraining.append(contentsOf: weightTraining)
            }
        } else {
            let myRoutine = MyRoutine(id: UUID().uuidString, name: name, stamp: stamp, myWeightTraining: weightTraining)
            SwiftDataManager.shared.createData(data: myRoutine)
        }
    }
    
    func setRoutine(routineIndex: Int?, weightTraining: [WeightTraining], id: Int) {
        let temporaryRoutine = TemporaryRoutine(id: 0, intDate: id)
        
        if let index = routineIndex {
            let myRoutines = loadMyRoutine()
            guard myRoutines.indices.contains(index) else { return }
            let myRoutine = myRoutines[index]
            temporaryRoutine.name = myRoutine.name
            temporaryRoutine.stamp = myRoutine.stamp
        } else {
            temporaryRoutine.name = ""
            temporaryRoutine.stamp = ""
        }
        temporaryRoutine.intDate = id
        temporaryRoutine.weightTraining.append(contentsOf: setWeightTraining(weightTraining))
        SwiftDataManager.shared.createData(data: temporaryRoutine)
    }
    
    func setWeightTraining(_ weightTraining: [WeightTraining]) -> [WeightTraining] {
        for training in weightTraining {
            training.weightTrainingInfo.append(WeightTrainingInfo(setCount: 1, weight: nil, trainingCount: nil))
        }
        return weightTraining
    }
    
    func deleteRoutine(id: [String]) {
        for myRoutineId in id {
            if let myRoutine = SwiftDataManager.shared.readData(id: myRoutineId, type: MyRoutine.self) {
                SwiftDataManager.shared.deleteData(data: myRoutine)
            }
        }
    }
}
