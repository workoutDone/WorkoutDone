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
        let workoutTimeData : Driver<String>
        let workoutRoutineTitleData : Driver<String>
        let isWorkout : Driver<Bool>
    }
    
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData?  {
        let selectedWorkoutDoneData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedWorkoutDoneData
    }
    
    func convertIntToTimeValue(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        return timeString
    }
    
    func transform(input : Input) -> Output {
        let weightData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let weight = self.readWorkoutDoneData(id: date)?.bodyInfo?.weight
            if let validWeight = weight {
                return String(validWeight.truncateDecimalPoint())
            }
            else {
                return "-"
            }
        })
        let skeletalMusleMassData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let skeletalMusleMass = self.readWorkoutDoneData(id: date)?.bodyInfo?.skeletalMuscleMass
            if let validSkeletalMusleMass = skeletalMusleMass {
                return String(validSkeletalMusleMass.truncateDecimalPoint())
            }
            else {
                return "-"
            }
            
        })
        let fatPercentageData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let fatPercentage = self.readWorkoutDoneData(id: date)?.bodyInfo?.fatPercentage
            if let validFatPercentage = fatPercentage {
                return String(validFatPercentage.truncateDecimalPoint())
            }
            else {
                return "-"
            }
        })
        let imageData = Driver<UIImage>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (load, date) in
            let imageData = self.readWorkoutDoneData(id: date)?.frameImage?.image
            if let validImageData = imageData {
                return UIImage(data: validImageData)!
            }
            else {
                return UIImage()
            }
        })
        
        let workoutTimeData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, date) in
            let timeValue = self.readWorkoutDoneData(id: date)?.workOutTime
            if let timeValue = timeValue {
                let timeString = self.convertIntToTimeValue(timeValue)
                return timeString
            }
            else {
                return "00:00:00"
            }
        })
        
        let workoutRoutineTitleData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, date) in
            let routineTitleValue = self.readWorkoutDoneData(id: date)?.routine?.name
            
            if let routineTitleValue = routineTitleValue {
                ///비어있을때 해야함 todo
                return routineTitleValue
            }
            else {
                return "-"
            }
        })
        
        let isWorkout = Driver<Bool>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, date) in
            let weightTrainingData = self.readWorkoutDoneData(id: date)?.routine?.weightTraining
            if let _ = weightTrainingData {
                return true
                
            }
            else {
                return false
            }
        })

        return Output(
            weightData: weightData,
            skeletalMusleMassData: skeletalMusleMassData,
            fatPercentageData: fatPercentageData,
            imageData: imageData,
            workoutTimeData: workoutTimeData,
            workoutRoutineTitleData: workoutRoutineTitleData,
            isWorkout: isWorkout)
    }
}
