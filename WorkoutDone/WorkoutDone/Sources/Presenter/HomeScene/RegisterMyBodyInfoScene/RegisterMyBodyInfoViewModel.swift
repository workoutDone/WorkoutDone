//
//  RegisterMyBodyInfoViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/21.
//

import RxSwift
import RxCocoa

class RegisterMyBodyInfoViewModel {
    
    struct Input {
        let weightInputText : Driver<String>
        let skeletalMusleMassInputText : Driver<String>
        let fatPercentageInputText : Driver<String>
    }
    struct Output {
        let weightOutputText : Driver<String>
        let skeletalMusleMassOutputText : Driver<String>
        let fatPercentageOutputtText : Driver<String>
    }
    func trimText(text: String) -> String {
//        var value = ""
//        print("ddd")
//        if text.count > 3 {
//            print("sss")
//            let index = text.index(text.startIndex, offsetBy: 3)
//            value = String(text[..<index])
//        }
//        return value]
        return ""
    }
    
    func transform(input: Input) -> Output {
        let weightText = input.weightInputText.map { value in
            print(value)
//            var newValue = ""
//            let index = value.index(value.startIndex, offsetBy: 3)
//            if value.count > 3 {
//                let
//            }
//            return String(value[..<index])
//            if value.count >= 3 {
//                let index = value.index(value.startIndex, offsetBy: 3)
//                let newValue = value[value.startIndex..<index]
//            }
//            newValue = newValue
//            return newValue
//            let newValue = self.trimText(text: value)
            return value
        }
        let skeletalMusleMassText = input.skeletalMusleMassInputText.map { value in
            return value
        }
        let fatPercentageText = input.fatPercentageInputText.map { value in
            return value
        }
        return Output(weightOutputText: weightText, skeletalMusleMassOutputText: skeletalMusleMassText, fatPercentageOutputtText: fatPercentageText)
    }
}
