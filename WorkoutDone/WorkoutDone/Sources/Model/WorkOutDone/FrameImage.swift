//
//  FrameImage.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import SwiftData

@Model
final class FrameImage {
    var frameType: Int
    var image: Data?

    init(frameType: Int = 0, image: Data? = nil) {
        self.frameType = frameType
        self.image = image
    }
}
