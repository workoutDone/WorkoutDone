//
//  PhotoFrameTypeViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/08.
//

import UIKit
import RxCocoa
import RxSwift
import RealmSwift

class PhotoFrameTypeViewModel {
    let realm = try! Realm()
    let realmManager = RealmManager.shared
    
    struct Input {
        let frameTypeButtonStatus : Driver<Bool>
        let selectedFrameType : Driver<Int>
        let selectedPhoto : Driver<UIImage>
        let selectedDate : Driver<Int>
        let saveButtonTapped : Driver<Void>
    }
    
    struct Output {
        let saveButtonStatus : Driver<Bool>
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
//        try! realm.write {
//            realm.add(workoutDoneData)
//            workoutDoneData.frameImage?.insert
//        }
    }
    ///Realm Read
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData? {
        let selectedWorkoutDoneData = realmManager.readData(id: id, type: WorkOutDoneData.self)
        return selectedWorkoutDoneData
    }
    
    ///Realm Update
    func updateFrameImageData(image : UIImage, id : Int, date : String, frameType : Int) {
//        let workoutDoneData = WorkOutDoneData(id: id, date: date)
//        let frameImage = FrameImage()
//        frameImage.image = image.pngData()
//        frameImage.frameType = frameType
//        realmManager.updateData(data: workoutDoneData)
        try! realm.write {
            let workoutDoneData = WorkOutDoneData(id: id, date: date)
            let frameImage = FrameImage()
            frameImage.image = image.pngData()
            frameImage.frameType = frameType
            workoutDoneData.frameImage = frameImage
            print("UPdated person: \(workoutDoneData)")
        }
    }
    
    ///id값으로 데이터가 있는지 판별
    func validFrameImageData(id : Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.frameImage == nil ? false : true
    }
    func validBodyInfoData(id : Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData == nil ? false : true
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
        
        let inputData = Driver<Void>.combineLatest(input.selectedPhoto, input.selectedFrameType, input.selectedDate, input.saveButtonTapped, resultSelector: { (image, frame, id, _) in
            let convertData = self.convertIDToDateString(dateInt: id)
            guard let dateValue = convertData else { return }
            print("됐나????")
            ///데이터가 존재하는 경우
            if self.validBodyInfoData(id: id) {
                ///FrameImage 데이터 존재하는 경우 - update
                if self.validFrameImageData(id: id) {
                    print("FrameImage 데이터 존재하는 경우 - update")
                    let workoutDoneData = self.readWorkoutDoneData(id: id)
                    print(workoutDoneData, "?????/")
                    try! self.realm.write {
                        workoutDoneData?.frameImage?.image = image.pngData()
                        workoutDoneData?.frameImage?.frameType = frame
                    }
//                    workoutDoneData?.frameImage?.frameType = frame
//                    workoutDoneData?.frameImage?.image = image.pngData()
//                    self.realmManager.updateData(data: workoutDoneData)
                }
                ///FrameImage 데이터 존재하는 않는 경우 - create
                else {
                    print("FrameImage 데이터 존재하는 않는 경우 - create")
                    guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
                    let frameImage = FrameImage()
                    frameImage.frameType = frame
                    frameImage.image = image.pngData()
                    try! self.realm.write {
                        workoutDoneData.frameImage = frameImage
                        self.realm.add(workoutDoneData)
                    }
//                    print(workoutDoneData, "?????/")
////                    try! self.realm.write {
////                        workoutDoneData?.frameImage?.image = image.pngData()
////                        workoutDoneData?.frameImage?.frameType = frame
////                    }
//                    workoutDoneData?.frameImage?.frameType = frame
//                    workoutDoneData?.frameImage?.image = image.pngData()
//                    self.realmManager.createData(data: workoutDoneData?.frameImage)
                    
                    
//                    if let workoutDoneData = self.readWorkoutDoneData(id: id) {
//                        if let frameImage = workoutDoneData.frameImage {
//                            try! self.realm.write {
//                                frameImage.frameType = frame
//                                frameImage.image = image.pngData()
//                            }
//                        }
//                    }
//                    if let workoutDoneData = self.readWorkoutDoneData(id: id), !workoutDoneData.isInvalidated {
//                        workoutDoneData.frameImage?.image = image.pngData()
//                        workoutDoneData.frameImage?.frameType = frame
//
//                        if !workoutDoneData.isValid {
//                            try! self.realm.write {
//                                realm.add(workoutDoneData)
//                            }
//                        }
//                    }
                    
                }
            }
            ///데이터가 존재하지 않는 경우 - create
            else {
                self.createFrameImageData(
                    image: image,
                    id: id,
                    date: dateValue,
                    frameType: frame)
            }
                
//            if self.validBodyInfoData(id: id) {
//                print("데이터 전혀 없는 경우")
//                ///데이터가 전혀 없는 경우
//                self.updateFrameImageData(
//                    image: image,
//                    id: id,
//                    date: dateValue,
//                    frameType: frame)
//            }
//            else {
//                /// BodyInfo 에 값이 있는 경우
//                if self.validBodyInfoData(id: id) {
//
//                    print("크리에이트")
//                    ///값이 존재하지 않는 경우
//                    self.createFrameImageData(
//                        image: image,
//                        id: id,
//                        date: dateValue,
//                        frameType: frame)
//                }
//                else {
//                    print("업데이트")
//                    ///값이 존재하는 경우
//                    self.updateFrameImageData(
//                        image: image,
//                        id: id,
//                        date: dateValue,
//                        frameType: frame)
//                }
//            }
        })

        
        return Output(
            saveButtonStatus: input.frameTypeButtonStatus,
            saveData: inputData)
    }
}
//let resizedImage = resizeImage(image: captureImage!, newSize: CGSize(width: view.frame.width, height: view.frame.width * (4 / 3)))
//frameImageViewModel.saveImageToRealm(date: Date(), frameType: 0, image: resizedImage)
//func saveImageToRealm(date: Date, frameType: Int, image: UIImage) {
//    guard let imageData = image.pngData() else { return }
//
//    let workOutDone = WorkOutDoneData(id: date.dateToInt(), date: date.yyyyMMddToString())
//    workOutDone.frameImage = FrameImage(frameType: frameType, image: imageData)
//
//    let realm = try! Realm()
//    try! realm.write {
//        realm.add(workOutDone)
//    }
//}
