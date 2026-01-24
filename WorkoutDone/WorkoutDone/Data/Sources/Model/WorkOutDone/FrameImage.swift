//
//  FrameImage.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import SwiftData

@Model
public final class FrameImage {
    public var frameType: Int
    public var image: Data?

    public init(frameType: Int = 0, image: Data? = nil) {
        self.frameType = frameType
        self.image = image
    }
}
