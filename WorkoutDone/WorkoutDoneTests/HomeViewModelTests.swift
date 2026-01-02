//
//  HomeViewModelTests.swift
//  WorkoutDoneTests
//
//  Created by Codex on 2025/02/14.
//

import XCTest
@testable import WorkoutDone

final class HomeViewModelTests: XCTestCase {
    private final class StubWorkOutDoneDataProvider: WorkOutDoneDataProviding {
        private var dataById: [Int: WorkOutDoneData]

        init(dataById: [Int: WorkOutDoneData]) {
            self.dataById = dataById
        }

        func workoutDoneData(for id: Int) -> WorkOutDoneData? {
            return dataById[id]
        }
    }

    func test_makeViewState_whenNoData_thenReturnsPlaceholders() {
        let sut = HomeViewModel(dataProvider: StubWorkOutDoneDataProvider(dataById: [:]))

        let viewState = sut.makeViewState(for: 20240101)

        XCTAssertEqual(viewState.weightText, "-")
        XCTAssertEqual(viewState.skeletalMuscleMassText, "-")
        XCTAssertEqual(viewState.fatPercentageText, "-")
        XCTAssertEqual(viewState.workoutTimeText, "00:00:00")
        XCTAssertEqual(viewState.workoutRoutineTitleText, "-")
        XCTAssertEqual(viewState.isWorkout, false)
        XCTAssertEqual(viewState.routineBodyParts, [])
        XCTAssertEqual(viewState.hasRoutineTitle, true)
        XCTAssertEqual(viewState.image.size, .zero)
    }

    func test_makeViewState_whenBodyInfoExists_thenFormatsValues() {
        let data = makeWorkOutDoneData(
            id: 20240102,
            routineName: "Leg Day",
            bodyParts: ["Leg"],
            weight: 70.1,
            skeletalMuscleMass: 32.4,
            fatPercentage: 18.9,
            workOutTime: 3661
        )
        let sut = HomeViewModel(dataProvider: StubWorkOutDoneDataProvider(dataById: [20240102: data]))

        let viewState = sut.makeViewState(for: 20240102)

        XCTAssertEqual(viewState.weightText, "70.1")
        XCTAssertEqual(viewState.skeletalMuscleMassText, "32.4")
        XCTAssertEqual(viewState.fatPercentageText, "18.9")
        XCTAssertEqual(viewState.workoutTimeText, "01:01:01")
        XCTAssertEqual(viewState.workoutRoutineTitleText, "Leg Day")
        XCTAssertEqual(viewState.isWorkout, true)
        XCTAssertEqual(viewState.routineBodyParts, [])
        XCTAssertEqual(viewState.hasRoutineTitle, true)
    }

    func test_makeViewState_whenRoutineTitleEmpty_thenReturnsBodyPartsAndHasRoutineTitleFalse() {
        let data = makeWorkOutDoneData(
            id: 20240103,
            routineName: "",
            bodyParts: ["Leg", "Back", "Leg"]
        )
        let sut = HomeViewModel(dataProvider: StubWorkOutDoneDataProvider(dataById: [20240103: data]))

        let viewState = sut.makeViewState(for: 20240103)

        XCTAssertEqual(viewState.isWorkout, true)
        XCTAssertEqual(viewState.routineBodyParts, ["Leg", "Back"])
        XCTAssertEqual(viewState.hasRoutineTitle, false)
    }

    private func makeWorkOutDoneData(
        id: Int,
        routineName: String? = nil,
        bodyParts: [String] = [],
        weight: Double? = nil,
        skeletalMuscleMass: Double? = nil,
        fatPercentage: Double? = nil,
        workOutTime: Int? = nil
    ) -> WorkOutDoneData {
        let data = WorkOutDoneData(id: id, date: "20240101")
        let bodyInfo = BodyInfo()
        bodyInfo.weight = weight
        bodyInfo.skeletalMuscleMass = skeletalMuscleMass
        bodyInfo.fatPercentage = fatPercentage
        data.bodyInfo = bodyInfo

        if let routineName = routineName {
            var weightTrainingList: [WeightTraining] = []
            for bodyPart in bodyParts {
                weightTrainingList.append(WeightTraining(bodyPart: bodyPart, weightTraining: "Dummy"))
            }
            data.routine = Routine(name: routineName, stamp: "", weightTraining: weightTrainingList)
        }

        data.workOutTime = workOutTime
        return data
    }
}
