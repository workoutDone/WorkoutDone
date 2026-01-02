import Foundation

class WorkoutDoneDataManager {
    let dataManager: SwiftDataManager

    init(dataManager: SwiftDataManager) {
        self.dataManager = dataManager
    }
    func readWorkoutDoneData(id: Int) -> WorkOutDoneData? {
        let workoutDoneData = dataManager.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
}
