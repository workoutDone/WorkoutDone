//
//  RegisterMyBodyInfoViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/21.
//

import RxSwift
import RxCocoa
import RealmSwift
import UIKit

class RegisterMyBodyInfoViewModel {
    let realm = try! Realm()
    var workOutDoneData : Results<WorkOutDoneData>?
    init(workOutDoneData: Results<WorkOutDoneData>? = nil) {
        self.workOutDoneData = realm.objects(WorkOutDoneData.self)
    }
    
    struct Input {
        let weightInputText : Driver<String>
        let skeletalMusleMassInputText : Driver<String>
        let fatPercentageInputText : Driver<String>
        let saveButtonTapped : Driver<Void>
        let selectedDate : Driver<Date>
    }
    struct Output {
        let weightOutputText : Driver<String>
        let skeletalMusleMassOutputText : Driver<String>
        let fatPercentageOutputText : Driver<String>

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
    
    func createBodyInfoData(weight : Double, skeletalMusleMass : Double, fatPercentage : Double, date : Date) {
        do {
            try realm.write {
                let workoutDoneData = WorkOutDoneData(id: 1, date: date)
                let bodyInfo = BodyInfo()
                bodyInfo.wegiht = weight
                bodyInfo.skeletalMuscleMass = skeletalMusleMass
                bodyInfo.fatPercentage = fatPercentage
                workoutDoneData.bodyInfo = bodyInfo
                realm.add(workoutDoneData)
            }
        }
        catch {
            print("Error saving \(error)")
        }
    }
    
    func transform(input: Input) -> Output {
        let weightText = input.weightInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value )
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        
        let skeletalMusleMassText = input.skeletalMusleMassInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value )
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        
        let fatPercentageText = input.fatPercentageInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value )
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        
        let saveBodyInfoData = Driver<Void>.combineLatest(weightText, skeletalMusleMassText, fatPercentageText, input.selectedDate, resultSelector: { (weight, skeletalMusle, fatPercentage, date) in
            self.createBodyInfoData(
                weight: Double(weight) ?? 0,
                skeletalMusleMass: Double(skeletalMusle) ?? 0,
                fatPercentage: Double(fatPercentage) ?? 0,
                date: date)
        })
                                                          
        return Output(
            weightOutputText: weightText,
            skeletalMusleMassOutputText: skeletalMusleMassText,
            fatPercentageOutputText: fatPercentageText)
    }
}
