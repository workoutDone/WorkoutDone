import UIKit

import RealmSwift
import RxCocoa
import RxSwift


//class

struct RegisterMyBodyInfoViewModel: ViewModelType {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    var workOutDoneData: Results<WorkOutDoneData>?
    init(workOutDoneData: Results<WorkOutDoneData>? = nil) {
        self.workOutDoneData = realm.objects(WorkOutDoneData.self)
    
    }

    struct Input {
        let loadView: Driver<Void>
        let weightInputText: Driver<String>
        let skeletalMusleMassInputText: Driver<String>
        let fatPercentageInputText: Driver<String>
        let saveButtonTapped: Driver<BodyInputData>
        let selectedDate: Driver<Int>
    }
    struct Output {
        let weightOutputText: Driver<String>
        let skeletalMusleMassOutputText: Driver<String>
        let fatPercentageOutputText: Driver<String>
        let saveData: Driver<Bool>
        let readWeightData: Driver<String>
        let readSkeletalMusleMassData: Driver<String>
        let readFatPercentageData: Driver<String>
    }
    /// 최대 3글자로 제한
    /// Realm Create
    func createBodyInfoData(weight: Double?, skeletalMusleMass: Double?, fatPercentage: Double?, date: String, id: Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let bodyInfo = BodyInfo()
        bodyInfo.weight = weight
        bodyInfo.skeletalMuscleMass = skeletalMusleMass
        bodyInfo.fatPercentage = fatPercentage
        workoutDoneData.bodyInfo = bodyInfo
        realmManager.createData(data: workoutDoneData)
    }
    /// Realm Update
    func updateBodyInfoData(weight: Double?, skeletalMusleMass: Double?, fatPercentage: Double?, date: String, id: Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let bodyInfo = BodyInfo(value: ["weight": weight, "skeletalMuscleMass": skeletalMusleMass, "fatPercentage": fatPercentage])
        workoutDoneData.bodyInfo = bodyInfo
        RealmManager.shared.updateData(data: workoutDoneData)
    }
    /// id값으로 데이터가 있는지 판별
    func validBodyInfoData(id: Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.bodyInfo == nil ? false : true
    }
    func validWorkoutDoneData(id: Int) -> Bool {
        let selectedWorkoutDoneData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedWorkoutDoneData == nil ? false : true
    }
    /// id값으로 workoutDoneData 가져오기
    func readWorkoutDoneData(id: Int) -> WorkOutDoneData? {
        let workoutDoneData = RealmManager.shared.readData(id: id, type: WorkOutDoneData.self)
        return workoutDoneData
    }
    func deleteBodyInfoData(id: Int) {
        if let workOutDoneData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id) {
            RealmManager.shared.deleteData(workOutDoneData.bodyInfo!)
        }

    }
    /// id 값(string) -> Date(string)으로 변경
    func convertIDToDateString(dateInt: Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: String(dateInt)) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    /// 올바른 표기인지 확인
    func checkValidInputData(weight: Double, skeletalMusleMass: Double, fatPercentage: Double) -> Bool {
        if weight > 200 || skeletalMusleMass > 100 || fatPercentage > 100 {
            return false
        } else {
             return true
        }
    }
    
    func transform(input: Input) -> Output {
        /// 텍스트필드 입력 값 - 몸무게
        
        let weightText = input.weightInputText.map { value in
            return value
        }
        /// 텍스트필드 입력 값 - 골격근량
        
        let skeletalMusleMassText = input.skeletalMusleMassInputText.map { value in
            return value
        }
        /// 텍스트필드 입력 값 - 체지방량
        
        let fatPercentageText = input.fatPercentageInputText.map { value in
            return value
        }

        /// 몸무게 데이터 확인(read)
        let readWeightData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, date) in
            if self.validBodyInfoData(id: date) {
                let weight = self.readWorkoutDoneData(id: date)?.bodyInfo?.weight
                if let doubleWeight = weight {
                    return String(doubleWeight)
                } else {
                    return ""
                }
            } else {
                return ""
            }
        })
        /// 골격근량 데이터 확인(read)
        let readSkeletalMusleMassData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, date) in
            if self.validBodyInfoData(id: date) {
                let skeletalMusleMass = self.readWorkoutDoneData(id: date)?.bodyInfo?.skeletalMuscleMass
                if let doubleSkeletalMusleMass = skeletalMusleMass {
                    return String(doubleSkeletalMusleMass)
                } else {
                    return ""
                }
            } else {
                return ""
            }

        })
        /// 체지방량 데이터  확인(read)
        let readFatPercentageData = Driver<String>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, date) in
            if self.validBodyInfoData(id: date) {
                let fatPercentage = self.readWorkoutDoneData(id: date)?.bodyInfo?.fatPercentage
                if let doubleFatPercentage = fatPercentage {
                    return String(doubleFatPercentage)
                } else {
                    return ""
                }
            } else {
                return ""
            }

        })

        /// 데이터 입력(update or create)
        let inputData = Driver<Bool>.combineLatest(input.saveButtonTapped, input.selectedDate, resultSelector: { (inputData, id) in
            let convertData = self.convertIDToDateString(dateInt: id)
            guard let dateValue = convertData else { return false }
            let weightDouble = Double(inputData.weight ?? "")
            let fatPercentageDouble = Double(inputData.fatPercentage ?? "")
            let skeletalMusleMassDouble = Double(inputData.skeletalMusleMass ?? "")
            if self.checkValidInputData(weight: weightDouble ?? 0, skeletalMusleMass: skeletalMusleMassDouble ?? 0, fatPercentage: fatPercentageDouble ?? 0) {
                /// 형식이 맞는 경우
                /// 데이터가 존재하는 경우
                if self.validWorkoutDoneData(id: id) {
                    /// BodyInfo 데이터 존재하는 경우 - update
                    if self.validBodyInfoData(id: id) {
                        let workoutDoneData = self.readWorkoutDoneData(id: id)
                        try! self.realm.write {
                            workoutDoneData?.bodyInfo?.weight = Double(inputData.weight ?? "")
                            workoutDoneData?.bodyInfo?.fatPercentage = Double(inputData.fatPercentage ?? "")
                            workoutDoneData?.bodyInfo?.skeletalMuscleMass = Double(inputData.skeletalMusleMass ?? "")
                        }
                    } else {
                        guard let workOutDoneData = self.readWorkoutDoneData(id: id) else { return false }
                        let bodyInfo = BodyInfo()
                        bodyInfo.weight = Double(inputData.weight ?? "")
                        bodyInfo.skeletalMuscleMass = Double(inputData.skeletalMusleMass ?? "")
                        bodyInfo.fatPercentage = Double(inputData.fatPercentage ?? "")
                        try! self.realm.write {
                            workOutDoneData.bodyInfo = bodyInfo
                            self.realm.add(workOutDoneData)
                        }
                    }
                }
                /// 데이터가 존재하지 않는 경우 - create
                else {
                    self.createBodyInfoData(
                        weight: Double(inputData.weight ?? ""),
                        skeletalMusleMass: Double(inputData.skeletalMusleMass ?? ""),
                        fatPercentage: Double(inputData.fatPercentage ?? ""),
                        date: dateValue,
                        id: id)
                }
                return true
            }
            /// 형식이 맞지 않는 경우
            else {
                return false
            }
        })

        return Output(
            weightOutputText: weightText,
            skeletalMusleMassOutputText: skeletalMusleMassText,
            fatPercentageOutputText: fatPercentageText,
            saveData: inputData,
            readWeightData: readWeightData,
            readSkeletalMusleMassData: readSkeletalMusleMassData,
            readFatPercentageData: readFatPercentageData)
    }
}
