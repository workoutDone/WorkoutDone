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
        if text.count >= 3 {
            let index = text.index(text.startIndex, offsetBy: 3)
            let newString = text[text.startIndex..<index]
            return String(newString)
            
        }
        else {
            return text
        }
    }
    func ignoreZeroText(text: String) -> String {
        if text.count >= 1 && text[text.startIndex] == "0" {
            return ""
        }
        else {
            return text
        }
    }
    
    func transform(input: Input) -> Output {
        let weightText = input.weightInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value)
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        let skeletalMusleMassText = input.skeletalMusleMassInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value)
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        let fatPercentageText = input.fatPercentageInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value)
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        return Output(
            weightOutputText: weightText,
            skeletalMusleMassOutputText: skeletalMusleMassText,
            fatPercentageOutputtText: fatPercentageText)
    }
}
