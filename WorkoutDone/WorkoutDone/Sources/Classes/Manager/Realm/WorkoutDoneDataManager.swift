import Foundation

class WorkoutDoneDataManager {
    let realmManager: RealmManager
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    func readWorkoutDoneData(id: Int) -> WorkOutDoneData? {
        let workoutDoneData = realmManager.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
}
