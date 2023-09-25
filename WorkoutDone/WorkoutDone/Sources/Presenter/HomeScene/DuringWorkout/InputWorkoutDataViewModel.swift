//
//  InputWorkoutDataViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/18.
//

import UIKit
import RxSwift
import RxCocoa
import RealmSwift

class InputWorkoutDataViewModel {
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
    let realm = try! Realm()
    let realmManager = RealmManager3.shared
    
    struct Input {
        let countInputText : Driver<String>
        let weightInputText : Driver<String>
        let buttonTapped : Driver<Void>
        let weightTrainingArrayIndex : Driver<Int>
        let weightTrainingInfoArrayIndex : Driver<Int>
        let calisthenicsCountInputText : Driver<String>
    }
    
    struct Output {
        let outputData : Driver<Bool>
        let calisthenicsOutputData : Driver<Bool>
    }
    
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func updateCalisthenicsTemporaryRoutineData(count : Int, infoArrayIndex : Int, arrayIndex : Int) {
        let temporaryRoutineData = readTemporaryRoutineData()
        if let weightTrainingInfo = temporaryRoutineData?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex] {
            do {
                try realm.write {
                    weightTrainingInfo.weight = nil
                    weightTrainingInfo.trainingCount = count
    
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    func updateTemporaryRoutineData(count : Int, weight : Double, infoArrayIndex : Int, arrayIndex : Int) {
        let temporaryRoutineData = readTemporaryRoutineData()
        if let weightTrainingInfo = temporaryRoutineData?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex] {
            do {
                try realm.write {
                    weightTrainingInfo.weight = weight
                    weightTrainingInfo.trainingCount = count
                }
            }
            catch {
                print(error)
            }
        }
    }
    
    
    func checkValidInputData(weight: Double, count: Int) -> Bool {
        if weight > 1000 || count > 1000 {
            print(weight, count)
            return false
        }
        else {
            return true
        }
    }
    func calisthenicsCheckValidInputData(count: Int) -> Bool {
        if count > 1000 {
            return false
        }
        else {
            return true
        }
    }
    
    func transform(input: Input) -> Output {
        let inputData = Driver<Bool>.combineLatest(
            input.countInputText,
            input.weightInputText,
            input.weightTrainingArrayIndex,
            input.weightTrainingInfoArrayIndex,
            input.buttonTapped,
            resultSelector: { (count, weight, arrayIndex, infoArrayIndex, _) in
            let IntCount = Int(count) ?? 0
            let doubleWeight = Double(weight) ?? 0
            
            if self.checkValidInputData(weight: doubleWeight, count: IntCount) {
                self.updateTemporaryRoutineData(count: IntCount, weight: doubleWeight, infoArrayIndex: infoArrayIndex, arrayIndex: arrayIndex)
                return true
            }
            else {
                return false
            }
        })
        let calisthenicsInputData = Driver<Bool>.combineLatest(
            input.buttonTapped,
            input.weightTrainingInfoArrayIndex,
            input.weightTrainingArrayIndex,
            input.calisthenicsCountInputText,
            resultSelector: { (_, infoArrayIndex, arrayIndex, count) in
                let IntCount = Int(count) ?? 0
                if self.calisthenicsCheckValidInputData(count: IntCount) {
                    self.updateCalisthenicsTemporaryRoutineData(count: IntCount, infoArrayIndex: infoArrayIndex, arrayIndex: arrayIndex)
                    return true
                }
                else {
                    return false
                }
            })
        return Output(
            outputData: inputData,
            calisthenicsOutputData: calisthenicsInputData)
    }
}
