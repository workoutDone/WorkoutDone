//
//  Routine.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/05/13.
//

import Foundation
import RealmSwift

class Routine : Object {
    @Persisted dynamic var name : String
    @Persisted dynamic var image : String
    @Persisted dynamic var bodyPart: List<BodyPart>

    convenience init(name: String, image: String, bodyPart: List<BodyPart>) {
        self.init()
        self.name = name
        self.image = image
        self.bodyPart = bodyPart
    }
}
