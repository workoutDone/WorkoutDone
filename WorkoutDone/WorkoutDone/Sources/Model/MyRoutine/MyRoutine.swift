//
//  MyRoutine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class MyRoutine : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var image : String
    @Persisted dynamic var myBodyPart: List<MyBodyPart>

    convenience init(name: String, image: String, myBodyPart: List<MyBodyPart>) {
        self.init()
        self.name = name
        self.image = image
        self.myBodyPart = myBodyPart
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
