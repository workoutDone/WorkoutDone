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
    
    //struct
    var test = PublishSubject<Void>()
    struct Input {
        let loadView : Driver<Void>
        let weightInputText : Driver<String>
        let skeletalMusleMassInputText : Driver<String>
        let fatPercentageInputText : Driver<String>
        let saveButtonTapped : Driver<BodyInputData>
        let selectedDate : Driver<String>
    }
    struct Output {
        let weightOutputText : Driver<String>
        let skeletalMusleMassOutputText : Driver<String>
        let fatPercentageOutputText : Driver<String>
        let saveData : Driver<Void>
        let isConfirmEnabled : Driver<Bool>
        let readWeightData : Driver<String>
        let readSkeletalMusleMassData : Driver<String>
        let readFatPercentageData : Driver<String>
    }
    ///최대 3글자로 제한
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
    ///첫글자 "0" 막기
    func ignoreZeroText(text: String) -> String {
        if text.count >= 1 && text[text.startIndex] == "0" {
            return ""
        }
        else {
            return text
        }
    }
    ///Realm Create
    func createBodyInfoData(weight : Double?, skeletalMusleMass : Double?, fatPercentage : Double?, date : String, id : Int) {
        do {
            try realm.write {
                let workoutDoneData = WorkOutDoneData(id: id, date: date)
                let bodyInfo = BodyInfo()
                bodyInfo.weight = weight
                bodyInfo.skeletalMuscleMass = skeletalMusleMass
                bodyInfo.fatPercentage = fatPercentage
                workoutDoneData.bodyInfo = bodyInfo
                realm.add(workoutDoneData)
                //??
                test.onNext(())
                
                print("렘 세ㅇ")
            }
        }
        catch {
            print("Error saving \(error)")
        }
    }
    ///Realm Update
    func updateBodyInfoData(weight: Double?, skeletalMusleMass : Double?, fatPercentage : Double?, date : String, id : Int) {
        do {
            try realm.write {
                let workoutDoneData = WorkOutDoneData(id: id, date: date)
                let bodyInfo = BodyInfo(value: ["weight" : weight, "skeletalMuscleMass" : skeletalMusleMass, "fatPercentage" : fatPercentage])
                workoutDoneData.bodyInfo = bodyInfo
                realm.add(workoutDoneData, update: .modified)
            }
        }
        catch {
            print("Error updating \(error)")
        }
    }
    ///id값으로 데이터가 있는지 판별
    func validBodyInfoData(id : Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.bodyInfo == nil ? false : true
    }
    ///id값으로 BodyInfoData 가져오기
    func readBodyInfoData(id : Int) -> WorkOutDoneData?  {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData
    }
    ///id 값(string) -> Date(string)으로 변경
    func convertIDToDateString(dateString : String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date)
        }
        else {
            return nil
        }
    }
    
    func transform(input: Input) -> Output {
        ///텍스트필드 입력 값 - 몸무게
        let weightText = input.weightInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value )
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        ///텍스트필드 입력 값 - 골격근량
        let skeletalMusleMassText = input.skeletalMusleMassInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value )
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        ///텍스트필드 입력 값 - 체지방량
        let fatPercentageText = input.fatPercentageInputText.map { value in
            let ignoreZeroValue = self.ignoreZeroText(text: value )
            let trimValue = self.trimText(text: ignoreZeroValue)
            return trimValue
        }
        
        ///버튼 활성화. 상태
        let buttonEnabled = Driver<Bool>.combineLatest(input.weightInputText, skeletalMusleMassText, fatPercentageText, resultSelector: { (weight, skeletalMusle, fatPercenatage) in
            if weight.count + skeletalMusle.count + fatPercenatage.count > 0 {
                return true
            }
            else {
                return false
            }
        })
        ///몸무게 데이터 확인(read)
        let readWeightData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            guard let idDate = Int(date) else { return "" }
            if self.validBodyInfoData(id: idDate) {
                let weight = self.readBodyInfoData(id: idDate)?.bodyInfo?.weight
                if let doubleWeight = weight {
                    return String(doubleWeight)
                }
                else {
                    return ""
                }
            }
            else {
                return ""
            }
        })
        ///골격근량 데이터 확인(read)
        let readSkeletalMusleMassData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            guard let idDate = Int(date) else { return "" }
            if self.validBodyInfoData(id: idDate) {
                let skeletalMusleMass = self.readBodyInfoData(id: idDate)?.bodyInfo?.skeletalMuscleMass
                if let doubleSkeletalMusleMass = skeletalMusleMass {
                    return String(doubleSkeletalMusleMass)
                }
                else {
                    return ""
                }
            }
            else {
                return ""
            }

        })
        ///체지방량 데이터  확인(read)
        let readFatPercentageData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            guard let idDate = Int(date) else { return "" }
            if self.validBodyInfoData(id: idDate) {
                let fatPercentage = self.readBodyInfoData(id: idDate)?.bodyInfo?.fatPercentage
                if let doubleFatPercentage = fatPercentage {
                    return String(doubleFatPercentage)
                }
                else {
                    return ""
                }
            }
            else {
                return ""
            }

        })

        ///데이터 입력(update or create)
        let inputData = Driver<Void>.combineLatest(input.saveButtonTapped, input.selectedDate, resultSelector: { (inputData, date) in
            guard let idValue = Int(date) else { return }
            let convertDate = self.convertIDToDateString(dateString: date)
            guard let dateValue = convertDate else { return }
            if self.validBodyInfoData(id: idValue) {
                ///값이 존재하는 경우
                self.updateBodyInfoData(
                    weight: Double(inputData.weight ?? ""),
                    skeletalMusleMass: Double(inputData.skeletalMusleMass ?? ""),
                    fatPercentage: Double(inputData.fatPercentage ?? ""),
                    date: dateValue,
                    id: idValue)
            }
            else {
                ///값이 존재하지 않는 경우
                self.createBodyInfoData(
                    weight: Double(inputData.weight ?? ""),
                    skeletalMusleMass: Double(inputData.skeletalMusleMass ?? ""),
                    fatPercentage: Double(inputData.fatPercentage ?? ""),
                    date: dateValue,
                    id: idValue)
            }
            
        })
        
        

        return Output(
            weightOutputText: weightText,
            skeletalMusleMassOutputText: skeletalMusleMassText,
            fatPercentageOutputText: fatPercentageText,
            saveData: inputData,
            isConfirmEnabled: buttonEnabled,
            readWeightData: readWeightData,
            readSkeletalMusleMassData: readSkeletalMusleMassData,
            readFatPercentageData: readFatPercentageData)
    }
}

