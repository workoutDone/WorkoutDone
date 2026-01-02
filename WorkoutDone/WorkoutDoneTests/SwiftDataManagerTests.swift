//
//  SwiftDataManagerTests.swift
//  WorkoutDoneTests
//
//  Created by Codex on 2025/02/14.
//

import XCTest
@testable import WorkoutDone

final class SwiftDataManagerTests: XCTestCase {
    func test_createReadUpdateDelete_workoutDoneData() {
        let provider = MockSwiftDataProvider()
        let manager = SwiftDataManager(context: provider.makeContext())

        let workout = WorkOutDoneData(id: 20240101, date: "2024.01.01")
        manager.createData(data: workout)

        let readWorkout = manager.readData(id: 20240101, type: WorkOutDoneData.self)
        XCTAssertNotNil(readWorkout)

        manager.updateData(data: workout) { updated in
            updated.workOutTime = 3600
        }
        let updatedWorkout = manager.readData(id: 20240101, type: WorkOutDoneData.self)
        XCTAssertEqual(updatedWorkout?.workOutTime, 3600)

        if let updatedWorkout = updatedWorkout {
            manager.deleteData(data: updatedWorkout)
        }
        let deletedWorkout = manager.readData(id: 20240101, type: WorkOutDoneData.self)
        XCTAssertNil(deletedWorkout)
    }
}
