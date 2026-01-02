import Foundation

class BodyInfoDataManager {
    let dataManager: SwiftDataManager

    init(dataManager: SwiftDataManager) {
        self.dataManager = dataManager
    }
    
    func readBodyInfoData(id: Int) -> BodyInfo? {
        let bodyInfoData = dataManager.readData(id: id, type: WorkOutDoneData.self)?.bodyInfo
        return bodyInfoData
    }
    
    func createBodyInfoData(weight: Double?, skeletalMusleMass: Double?, fatPercentage: Double?, date: String, id: Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let bodyInfo = BodyInfo(weight: weight, skeletalMuscleMass: skeletalMusleMass, fatPercentage: fatPercentage)
        workoutDoneData.bodyInfo = bodyInfo
        dataManager.createData(data: workoutDoneData)
    }
    func deleteBodyInfoData(id: Int) {
        if let workoutDoneData = dataManager.readData(id: id, type: WorkOutDoneData.self),
           let bodyInfo = workoutDoneData.bodyInfo {
            dataManager.deleteData(data: bodyInfo)
        }
    }
    func updateBodyInfoData(workoutDoneData: WorkOutDoneData, weight: Double?, skeletalMuscleMass: Double?, fatPercentage: Double?) {
        dataManager.updateData(data: workoutDoneData) { updatedWorkOutDoneData in
            updatedWorkOutDoneData.bodyInfo = BodyInfo(
                weight: weight,
                skeletalMuscleMass: skeletalMuscleMass,
                fatPercentage: fatPercentage
            )
        }
    }
}
