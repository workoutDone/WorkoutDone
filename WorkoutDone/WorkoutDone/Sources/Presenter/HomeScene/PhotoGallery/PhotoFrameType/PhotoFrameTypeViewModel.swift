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
//        let saveButtonTapped : Driver<FrameImage>
//        let selectedData : Driver<String>
    }
    
    struct Output {
        let saveButtonStatus : Driver<Bool>
        let saveData : Driver<Void>
    }
    
    func createFrameImageData(image : UIImage, id : Int, date : String, frameType : Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let frameImage = FrameImage()
        frameImage.image = image.pngData()
        frameImage.frameType = frameType
        workoutDoneData.frameImage = frameImage
        realmManager.createData(data: workoutDoneData)
    }
    
    ///id값으로 데이터가 있는지 판별
    func validBodyInfoData(id : Int) -> Bool {
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.frameImage == nil ? false : true
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
        
        let inputData = Driver<Void>.combineLatest(input.selectedPhoto, input.selectedFrameType, input.selectedDate, resultSelector: { (image, frame, date) in
            let convertData = self.convertIDToDateString(dateInt: date)
            guard let dateValue = convertData else { return }
            
            if self.validBodyInfoData(id: date) {
                ///값이 존재하는 경우
            }
            else {
                ///값이 존재하지 않는 경우
                self.createFrameImageData(
                    image: image,
                    id: date,
                    date: dateValue,
                    frameType: frame)
            }
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
