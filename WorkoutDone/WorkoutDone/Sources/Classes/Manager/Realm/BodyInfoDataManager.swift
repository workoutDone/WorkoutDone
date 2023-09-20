import Foundation

class BodyInfoDataManager {
    let realmManager: RealmManager
    
    init(realmManager: RealmManager) {
        self.realmManager = realmManager
    }
    
    func readBodyInfoData(id: Int) -> BodyInfo? {
        let bodyInfoData = realmManager.readData(id: id, type: WorkOutDoneData.self)?.bodyInfo
        return bodyInfoData
    }
    
    func createBodyInfoData(weight: Double?, skeletalMusleMass: Double?, fatPercentage: Double?, date: String, id: Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let bodyInfo = BodyInfo()
        bodyInfo.weight = weight
        bodyInfo.skeletalMuscleMass = skeletalMusleMass
        bodyInfo.fatPercentage = fatPercentage
        workoutDoneData.bodyInfo = bodyInfo
        realmManager.createData(data: workoutDoneData)
    }
    func deleteBodyInfoData(id: Int) {
        if let workoutDoneData = realmManager.readData(id: id, type: WorkOutDoneData.self) {
            realmManager.deleteData(data: workoutDoneData.bodyInfo!)
        }
    }
    func updateBodyInfoData(workoutDoneData: WorkOutDoneData, weight: Double?, skeletalMuscleMass: Double?, fatPercentage: Double?) {
        realmManager.updateData(data: workoutDoneData) { updatedWorkOutDoneData in
            let bodyInfo = BodyInfo()
            bodyInfo.weight = weight
            bodyInfo.skeletalMuscleMass = skeletalMuscleMass
            bodyInfo.fatPercentage = fatPercentage
            updatedWorkOutDoneData.bodyInfo = bodyInfo
            
        }
    }
}
