//
//  InputWorkoutDataViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/18.
//

import UIKit
import RxSwift
import RxCocoa

class InputWorkoutDataViewModel {
    let duringWorkoutRoutine = DuringWorkoutRoutine.shared
    
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
                let routine = self.duringWorkoutRoutine.routine
                routine?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex].weight = doubleWeight
                routine?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex].trainingCount = IntCount
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
                    let routine = self.duringWorkoutRoutine.routine
                    routine?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex].weight = nil
                    routine?.weightTraining[arrayIndex].weightTrainingInfo[infoArrayIndex].trainingCount = IntCount
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
