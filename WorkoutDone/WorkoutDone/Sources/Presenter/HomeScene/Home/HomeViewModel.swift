//
//  HomeViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/08.
//

import RxSwift
import RxCocoa
import SwiftData
import UIKit

protocol WorkOutDoneDataProviding {
    func workoutDoneData(for id: Int) -> WorkOutDoneData?
}


final class SwiftDataWorkOutDoneDataProvider: WorkOutDoneDataProviding {
    private let context: ModelContext

    init(context: ModelContext = SwiftDataStack.shared.context) {
        self.context = context
    }

    func workoutDoneData(for id: Int) -> WorkOutDoneData? {
        let predicate = #Predicate<WorkOutDoneData> { $0.id == id }
        var descriptor = FetchDescriptor<WorkOutDoneData>(predicate: predicate)
        descriptor.fetchLimit = 1
        return try? context.fetch(descriptor).first
    }
}

struct HomeWorkoutViewState {
    let weightText: String
    let skeletalMuscleMassText: String
    let fatPercentageText: String
    let image: UIImage
    let workoutTimeText: String
    let workoutRoutineTitleText: String
    let isWorkout: Bool
    let routineBodyParts: [String]
    let hasRoutineTitle: Bool
}

final class HomeViewModel {
    private let dataProvider: WorkOutDoneDataProviding

    init(dataProvider: WorkOutDoneDataProviding = SwiftDataWorkOutDoneDataProvider()) {
        self.dataProvider = dataProvider
    }
    struct Input {
        let selectedDate: Driver<Int>
        let loadView: Driver<Void>
    }
    struct Output {
        let weightData: Driver<String>
        let skeletalMusleMassData: Driver<String>
        let fatPercentageData : Driver<String>
        let imageData : Driver<UIImage>
        let workoutTimeData : Driver<String>
        let workoutRoutineTitleData : Driver<String>
        let isWorkout : Driver<Bool>
        let routineBodyPartArray : Driver<[String]>
        let hasRoutineTitle: Driver<Bool>
    }
    
    func readWorkoutDoneData(id: Int) -> WorkOutDoneData? {
        return dataProvider.workoutDoneData(for: id)
    }
    
    func convertIntToTimeValue(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = (seconds % 3600) % 60
        
        let timeString = String(format: "%02d:%02d:%02d", hours, minutes, remainingSeconds)
        return timeString
    }
    

    func sortBodyPart(id: Int) -> [String] {
        let workoutData = self.readWorkoutDoneData(id: id)
        guard let weightTraining = workoutData?.routine?.weightTraining else { return [] }
        let arrayWeightTraining = Array(weightTraining)
        
        let letterCounts = arrayWeightTraining.reduce(into: [:]) { counts, word in
            counts[word.bodyPart, default: 0] += 1
        }
        
        let sortedByCount = letterCounts.sorted { $0.value > $1.value }
        let result = sortedByCount.compactMap { $0.value > 0 ? $0.key : nil }
        
        return result
    }

    func makeViewState(for id: Int) -> HomeWorkoutViewState {
        let workoutDoneData = readWorkoutDoneData(id: id)
        let bodyInfo = workoutDoneData?.bodyInfo

        let weightText = bodyInfo?.weight.map { String($0.truncateDecimalPoint()) } ?? "-"
        let skeletalMuscleMassText = bodyInfo?.skeletalMuscleMass.map { String($0.truncateDecimalPoint()) } ?? "-"
        let fatPercentageText = bodyInfo?.fatPercentage.map { String($0.truncateDecimalPoint()) } ?? "-"
        let image = workoutDoneData?.frameImage?.image
            .map { UIImage(data: $0)! } ?? UIImage()
        let workoutTimeText = workoutDoneData?.workOutTime.map { convertIntToTimeValue($0) } ?? "00:00:00"
        let workoutRoutineTitleText = workoutDoneData?.routine?.name ?? "-"
        let isWorkout = workoutDoneData?.routine?.weightTraining != nil

        let routineTitle = workoutDoneData?.routine?.name ?? ""
        let isRoutineTitleEmpty = workoutDoneData != nil && routineTitle == ""
        let routineBodyParts = isRoutineTitleEmpty ? sortBodyPart(id: id) : []
        let hasRoutineTitle = !isRoutineTitleEmpty

        return HomeWorkoutViewState(
            weightText: weightText,
            skeletalMuscleMassText: skeletalMuscleMassText,
            fatPercentageText: fatPercentageText,
            image: image,
            workoutTimeText: workoutTimeText,
            workoutRoutineTitleText: workoutRoutineTitleText,
            isWorkout: isWorkout,
            routineBodyParts: routineBodyParts,
            hasRoutineTitle: hasRoutineTitle
        )
    }
    
    func transform(input: Input) -> Output {
        let viewState = Driver<HomeWorkoutViewState>.combineLatest(
            input.loadView,
            input.selectedDate,
            resultSelector: { [weak self] _, date in
                return self?.makeViewState(for: date) ?? HomeWorkoutViewState(
                    weightText: "-",
                    skeletalMuscleMassText: "-",
                    fatPercentageText: "-",
                    image: UIImage(),
                    workoutTimeText: "00:00:00",
                    workoutRoutineTitleText: "-",
                    isWorkout: false,
                    routineBodyParts: [],
                    hasRoutineTitle: true
                )
            }
        )

        return Output(
            weightData: viewState.map { $0.weightText },
            skeletalMusleMassData: viewState.map { $0.skeletalMuscleMassText },
            fatPercentageData: viewState.map { $0.fatPercentageText },
            imageData: viewState.map { $0.image },
            workoutTimeData: viewState.map { $0.workoutTimeText },
            workoutRoutineTitleData: viewState.map { $0.workoutRoutineTitleText },
            isWorkout: viewState.map { $0.isWorkout },
            routineBodyPartArray: viewState.map { $0.routineBodyParts },
            hasRoutineTitle: viewState.map { $0.hasRoutineTitle }
        )
    }
}
