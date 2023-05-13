//
//  FrameImage.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import RealmSwift

class FrameImage : Object {
    @Persisted dynamic var frameType : Int = 0
    @Persisted dynamic var image : Data?
    
    convenience init(frameType: Int, image: Data) {
        self.init()
        self.frameType = frameType
        self.image = image
    }
}
