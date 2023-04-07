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
        
    }
//    func transform(input : Input) -> Output {
//
//    }
}
