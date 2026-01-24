//
//  WorkOutDoneData.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/26.
//

import Foundation
import SwiftData

@Model
public final class WorkOutDoneData: IntIdentifiable {
    @Attribute(.unique) public var id: Int
    public var date: String
    public var frameImage: FrameImage?
    public var bodyInfo: BodyInfo?
    public var workOutTime: Int?
    public var routine: Routine?

    public init(
        id: Int,
        date: String = WorkOutDoneData.defaultDateString(),
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

    public static func defaultDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date())
    }
}
