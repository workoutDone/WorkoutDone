//
//  EndWorkoutViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/29.
//

import UIKit
import RealmSwift
import RxCocoa
import RxSwift

class EndWorkoutViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    
    struct Input {
        let saveTrigger : Driver<Void>
        let didLoad : Driver<Void>
        let totalWorkoutTime : Driver<Int>
    }
    
    struct Output {
        let saveData : Driver<Bool>
    }
    
    func validWorkoutDoneData(id : Int) -> Bool {
        let selectedWorkoutDoneData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedWorkoutDoneData == nil ? false : true
    }
    ///id값으로 Routine데이터가 있는지 판별
    func validRoutineData(id : Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.routine == nil ? false : true
    }
    
    ///id값으로 workoutDoneData 가져오기
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData?  {
        let workoutDoneData = RealmManager.shared.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
    ///id값으로 temporaryRoutineData 가져오기
    func readTemporaryRoutineData() -> TemporaryRoutine? {
        let temporaryRoutineData = realmManager.readData(id: 0, type: TemporaryRoutine.self)
        return temporaryRoutineData
    }
    
    func createRoutineData(id : Int, date : String, totalWorkoutTime : Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let temporaryRoutineData = readTemporaryRoutineData()
        let routine = Routine()
        if let temporaryRoutineData = temporaryRoutineData {
            routine.weightTraining = temporaryRoutineData.weightTraining
            routine.name = temporaryRoutineData.name
            routine.stamp = temporaryRoutineData.stamp
            workoutDoneData.routine = routine
            workoutDoneData.workOutTime = totalWorkoutTime
            realmManager.createData(data: workoutDoneData)
        }
    }
    ///id 값(string) -> Date(string)으로 변경
    func convertIDToDateString(dateInt : Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: String(dateInt)) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date)
        }
        else {
            return nil
        }
    }
    func transform(input : Input) -> Output  {
        
        let saveData = Driver<Bool>.combineLatest(
            input.saveTrigger,
            input.didLoad,
            input.totalWorkoutTime,
            resultSelector: { (_, _, time) in
                let temporaryRoutineData = self.readTemporaryRoutineData()
                guard let id = temporaryRoutineData?.intDate else { return false }
                
                let convertData = self.convertIDToDateString(dateInt: id)
                guard let dateValue =  convertData else { return false }
                print("????????웅???????")
                ///workoutDoneData 존재하는 경우
                if self.validWorkoutDoneData(id: id) {
                    ///Routine 데이터 존재하는 경우 - update
                    if self.validRoutineData(id: id) {
                        print("Routine 데이터 존재하는 경우 - update")
                        let workoutDoneData = self.readWorkoutDoneData(id: id)
                        if let temporaryRoutineData = self.readTemporaryRoutineData() {
                            try! self.realm.write {
                                workoutDoneData?.routine?.stamp = temporaryRoutineData.stamp
                                workoutDoneData?.routine?.name = temporaryRoutineData.name
                                workoutDoneData?.routine?.weightTraining = temporaryRoutineData.weightTraining
                                workoutDoneData?.workOutTime = time
                            }
                        }
                    }
                    else {
                        print("나머지 케이스")
                        let workoutDoneData = self.readWorkoutDoneData(id: id)
                        let routine = Routine()
                        if let temporaryRoutineData = self.readTemporaryRoutineData() {
                            routine.weightTraining = temporaryRoutineData.weightTraining
                            routine.name = temporaryRoutineData.name
                            routine.stamp = temporaryRoutineData.stamp
                            try! self.realm.write {
                                workoutDoneData?.routine = routine
                                workoutDoneData?.workOutTime = time
                                self.realm.add(workoutDoneData!)
                            }
                        }
                    }
                }
                /// 데이터가 존재하지 않는 경우 - create
                else {
                    self.createRoutineData(id: id, date: dateValue, totalWorkoutTime: time)
                    print("데이터가 존재하지 않는 경우 - create")
                }
                
                return true
            })
        return Output(saveData: saveData)
    }
}
