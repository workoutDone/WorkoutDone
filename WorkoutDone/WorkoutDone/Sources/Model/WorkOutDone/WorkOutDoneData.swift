//
//  WorkOutDoneData.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import RealmSwift

class WorkOutDoneData : Object {
    @Persisted dynamic var id : Int = 0
    @Persisted dynamic var date : String = Date().yyyyMMddToString()
    @Persisted dynamic var frameImage : FrameImage?
    @Persisted dynamic var bodyInfo : BodyInfo?
    @Persisted dynamic var workOutTime : Int?
    @Persisted dynamic var routine : Routine?
    
    convenience init(id: Int, date: String) {
        self.init()
        self.id = id
        self.date = date
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}


