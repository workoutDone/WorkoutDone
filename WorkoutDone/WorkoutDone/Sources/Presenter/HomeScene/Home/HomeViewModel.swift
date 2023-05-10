//
//  HomeViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/08.
//

import RxSwift
import RxCocoa
import RealmSwift
import UIKit

class HomeViewModel {
    let realm = try! Realm()
    var workOutDoneData : Results<WorkOutDoneData>?
    init(workOutDoneData: Results<WorkOutDoneData>? = nil) {
        self.workOutDoneData = realm.objects(WorkOutDoneData.self)
    
    }
    struct Input {
        let selectedDate : Driver<Int>
        let loadView : Driver<Void>
    }
    struct Output {
        let weightData : Driver<String>
        let skeletalMusleMassData : Driver<String>
        let fatPercentageData : Driver<String>
        let imageData : Driver<UIImage>
    }
    
    func readBodyInfoData(id : Int) -> WorkOutDoneData?  {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData
    }
    
    
    func transform(input : Input) -> Output {
        let weightData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let weight = self.readBodyInfoData(id: date)?.bodyInfo?.weight
            if let validWeight = weight {
                return String(validWeight)
            }
            else {
                return "-"
            }
        })
        let skeletalMusleMassData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let skeletalMusleMass = self.readBodyInfoData(id: date)?.bodyInfo?.skeletalMuscleMass
            if let validSkeletalMusleMass = skeletalMusleMass {
                return String(validSkeletalMusleMass)
            }
            else {
                return "-"
            }
            
        })
        let fatPercentageData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let fatPercentage = self.readBodyInfoData(id: date)?.bodyInfo?.fatPercentage
            if let validFatPercentage = fatPercentage {
                return String(validFatPercentage)
            }
            else {
                return "-"
            }
        })
        let imageData = Driver<UIImage>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let imageData = self.readBodyInfoData(id: date)?.frameImage?.image
            if let validImageData = imageData {
                return UIImage(data: validImageData)!
            }
            else {
                return UIImage()
            }
        })
        
        return Output(
            weightData: weightData,
            skeletalMusleMassData: skeletalMusleMassData,
            fatPercentageData: fatPercentageData,
            imageData: imageData)
    }
}
