//
//  RoutineViewModel.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/06/02.
//

import UIKit
import RealmSwift

struct RoutineViewModel {
    func loadMyRoutine() -> [MyRoutine] {
        let realm = try! Realm()
        
        let myRoutine = realm.objects(MyRoutine.self)
        
        return Array(myRoutine)
    }
    
    func loadMyRoutineName(id: String) -> String {
        let realm = try! Realm()
        
        guard let myRoutine = realm.objects(MyRoutine.self).filter("id == %@", id).first else {
            return ""
        }
        
        let myRoutineName = myRoutine.name
        
        return myRoutineName
    }
    
    func loadMyRoutineStamp(id: String) -> String {
        let realm = try! Realm()
        
        guard let myRoutine = realm.objects(MyRoutine.self).filter("id == %@", id).first else {
            return ""
        }
        
        let myRoutineStamp = myRoutine.stamp
        
        return myRoutineStamp 
    }
    
    func saveMyRoutine(id: String?, name: String, stamp: String, weightTraining: [MyWeightTraining]) {
        let realm = try! Realm()

        if let id = id, let existingMyRoutine = realm.object(ofType: MyRoutine.self, forPrimaryKey: id) {
            
            try! realm.write {
                existingMyRoutine.name = name
                existingMyRoutine.stamp = stamp
                existingMyRoutine.myWeightTraining.removeAll()
                existingMyRoutine.myWeightTraining.append(objectsIn: weightTraining)
               
                realm.add(existingMyRoutine)
            }
        } else {
            let myRoutine = MyRoutine()
    
            myRoutine.id = UUID().uuidString
            myRoutine.name = name
            myRoutine.stamp = stamp
            myRoutine.myWeightTraining.append(objectsIn: weightTraining)
            
            try! realm.write {
                realm.add(myRoutine)
            }
        }
    }
}

