//
//  RoutineViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/02.
//

import UIKit
import RealmSwift

struct RoutineViewModel {
    func loadMyRoutine() -> [String] {
        let realm = try! Realm()
        
        let myRoutine = realm.objects(MyRoutine.self)
        
        return Array(myRoutine.map{$0.name})
    }
    
    func loadMyRoutineDetail(routine: String) -> [MyRoutineDetail] {
        let realm = try! Realm()
        
        let myRoutine = realm.objects(MyRoutine.self).filter("name == %@", routine)
        let myBodyPart = Array(myRoutine.map{Array($0.myBodyPart)}).first!
        var myRoutineDetail = [MyRoutineDetail]()
        
        for bodyPart in myBodyPart {
            for weightTraining in bodyPart.myWeightTraining {
                myRoutineDetail.append(MyRoutineDetail(name: bodyPart.name, weightTraining: weightTraining.name))
            }
        }
        
        return myRoutineDetail
    }
}

