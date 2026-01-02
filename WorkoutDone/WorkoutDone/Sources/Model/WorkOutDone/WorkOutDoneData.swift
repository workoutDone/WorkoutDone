//
//  WorkOutDoneData.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import SwiftData

@Model
final class WorkOutDoneData: IntIdentifiable {
    @Attribute(.unique) var id: Int
    var date: String
    var frameImage: FrameImage?
    var bodyInfo: BodyInfo?
    var workOutTime: Int?
    var routine: Routine?

    init(
        id: Int,
        date: String = Date().yyyyMMddToString(),
        frameImage: FrameImage? = nil,
        bodyInfo: BodyInfo? = nil,
        workOutTime: Int? = nil,
        routine: Routine? = nil
    ) {
        self.id = id
        self.date = date
        self.frameImage = frameImage
        self.bodyInfo = bodyInfo
        self.workOutTime = workOutTime
        self.routine = routine
    }
}
