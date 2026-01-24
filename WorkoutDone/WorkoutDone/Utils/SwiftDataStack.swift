//
//  SwiftDataStack.swift
//  WorkoutDone
//
//  Created by Codex on 2025/02/14.
//

import SwiftData
import Data

final class SwiftDataStack {
    static let shared = SwiftDataStack()

    let container: ModelContainer
    let context: ModelContext

    private init() {
        container = try! ModelContainer(
            for: WorkOutDoneData.self,
            FrameImage.self,
            BodyInfo.self,
            Routine.self,
            WeightTraining.self,
            WeightTrainingInfo.self,
            MyRoutine.self,
            MyWeightTraining.self,
            TemporaryRoutine.self
        )
        context = ModelContext(container)
    }
}
