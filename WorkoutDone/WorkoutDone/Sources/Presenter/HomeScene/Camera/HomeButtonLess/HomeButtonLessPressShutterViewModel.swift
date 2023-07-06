//
//  HomeButtonLessPressShutterViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/24.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class HomeButtonLessPressShutterViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    var workOutDoneData : Results<WorkOutDoneData>?
    init(workOutDoneData: Results<WorkOutDoneData>? = nil) {
        self.workOutDoneData = realm.objects(WorkOutDoneData.self)
    
    }
    struct Input {
        let selectedData : Driver<Int>
        let selectedFrameType : Driver<Int>
        let capturedImage : Driver<UIImage>
        let saveButtonTapped : Driver<Void>
    }
    struct Output {
        let saveData : Driver<Void>
    }
    
    ///Realm Create
    func createFrameImageData(image : UIImage, id : Int, date : String, frameType : Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let frameImage = FrameImage()
        frameImage.image = image.pngData()
        frameImage.frameType = frameType
        workoutDoneData.frameImage = frameImage
        realmManager.createData(data: workoutDoneData)
    }
    
    ///Realm Read
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData? {
        let selectedWorkoutDoneData = realmManager.readData(id: id, type: WorkOutDoneData.self)
        return selectedWorkoutDoneData
    }
    
    ///id값으로 데이터가 있는지 판별
    func validFrameImageData(id : Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.frameImage == nil ? false : true
    }
    func validWorkoutDoneData(id : Int) -> Bool {
        let selectedWorkoutDoneData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedWorkoutDoneData == nil ? false : true
    }
    ///id 값(string) -> Date(string)으로 변경
    func convertIDToDateString(dateInt : Int) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        if let date = dateFormatter.date(from: String(dateInt)) {
            dateFormatter.dateFormat = "yyyy.MM.dd"
            return dateFormatter.string(from: date)
        }
        else {
            return nil
        }
    }
    
    func transform(input : Input) -> Output {
        let inputData = Driver<Void>.combineLatest(input.selectedData, input.capturedImage, input.selectedFrameType, input.saveButtonTapped, resultSelector: { (id, image, frame, _) in
            let convertData = self.convertIDToDateString(dateInt: id)
            guard let dataValue = convertData else { return }
            
            ///데이터 존재하는 경우
            if self.validWorkoutDoneData(id: id) {
                ///FrameImage 데이터 존재하는 경우 - update
                if self.validFrameImageData(id: id) {
                    print("FrameImage 데이터 존재하는 경우 - update")
                    let workoutDoneData = self.readWorkoutDoneData(id: id)
                    try! self.realm.write {
                        workoutDoneData?.frameImage?.image = image.pngData()
                        workoutDoneData?.frameImage?.frameType = frame
                    }
                }
                ///FrameImage 데이터 존재하는 경우 - create
                else {
                    print("FrameImage 데이터 존재하지 않는 경우 - create")
                    guard let workOutDoneData = self.readWorkoutDoneData(id: id) else { return }
                    let frameImage = FrameImage()
                    frameImage.frameType = frame
                    frameImage.image = image.pngData()
                    try! self.realm.write {
                        workOutDoneData.frameImage = frameImage
                        self.realm.add(workOutDoneData)
                    }
                }
            }
            ///데이터가 존재하지 않는 경우 - create
            else {
                self.createFrameImageData(image: image, id: id, date: dataValue, frameType: frame)
            }
        })
        return Output(saveData: inputData)
    }
}
