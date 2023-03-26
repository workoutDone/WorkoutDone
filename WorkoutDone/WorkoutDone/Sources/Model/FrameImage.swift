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
    @Persisted dynamic var imageName : String = ""
    //@Persisted dynamic var image : UIImage
    
    convenience init(frameType: Int, imageName: String) {
        self.init()
        self.frameType = frameType
        self.imageName = imageName
        //self.image = image
    }
}
