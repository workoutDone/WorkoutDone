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
    }
    struct Output {
        let weightData : Driver<String>
        let skeletalMusleMassData : Driver<String>
        let fatPercentageData : Driver<String>
    }
    
    func readBodyInfoData(id : Int) -> WorkOutDoneData?  {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData
    }
    
    
    func transform(input : Input) -> Output {
        
        let weightData = input.selectedDate.map { value in
            let weight = self.readBodyInfoData(id: value)?.bodyInfo?.weight
            if let stringWeight = weight {
                return String(stringWeight)
            }
            else {
                return "-"
            }
        }
        let skeletalMusleMassData = input.selectedDate.map { value in
            let skeletalMusleMass = self.readBodyInfoData(id: value)?.bodyInfo?.skeletalMuscleMass
            if let stringSkeletalMusleMass = skeletalMusleMass {
                return String(stringSkeletalMusleMass)
            }
            else {
                return "-"
            }
            
        }
        let fatPercentageData = input.selectedDate.map { value in
            let fatPercentage = self.readBodyInfoData(id: value)?.bodyInfo?.fatPercentage
            if let stringFatPercentage = fatPercentage {
                return String(stringFatPercentage)
            }
            else {
                return "-"
            }
        }
        
        return Output(
            weightData: weightData,
            skeletalMusleMassData: skeletalMusleMassData,
            fatPercentageData: fatPercentageData)
    }
}
