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
}

