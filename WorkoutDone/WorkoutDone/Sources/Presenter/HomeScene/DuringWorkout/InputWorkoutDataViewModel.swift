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
    
    struct Input {
        let countInputText : Driver<String>
        let weightInputText : Driver<String>
        let buttonTapped : Driver<Void>
    }
    
    struct Output {
        let outputData : Driver<Bool>
    }
    
    func checkValidInputData(weight: Double, count: Int) -> Bool {
        if weight > 1000 || count > 1000 {
            return false
        }
        else {
            return true
        }
    }
    
    func transform(input: Input) -> Output {
        let inputData = Driver<Bool>.combineLatest(input.countInputText, input.weightInputText, input.buttonTapped, resultSelector: { (count, weight, _) in
            let IntCount = Int(count) ?? 0
            let doubleWeight = Double(weight) ?? 0
            
            if self.checkValidInputData(weight: doubleWeight, count: IntCount) {
                return true
            }
            else {
                return false
            }
        })
        return Output(outputData: inputData)
    }
}
