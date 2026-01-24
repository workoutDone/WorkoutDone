//
//  PhotoFrameTypeViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/08.
//

import UIKit
import Data
import UIExtensions

class PhotoFrameTypeViewModel {
    private let dataManager = SwiftDataManager.shared
    
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
    
    ///SwiftData Create
    func createFrameImageData(image : UIImage, id : Int, date : String, frameType : Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let frameImage = FrameImage(frameType: frameType, image: image.pngData())
        workoutDoneData.frameImage = frameImage
        dataManager.createData(data: workoutDoneData)
    }
    ///SwiftData Read
    func readWorkoutDoneData(id : Int) -> WorkOutDoneData? {
        let selectedWorkoutDoneData = dataManager.readData(id: id, type: WorkOutDoneData.self)
        return selectedWorkoutDoneData
    }
    
    ///SwiftData Update
    func updateFrameImageData(image : UIImage, id : Int, date : String, frameType : Int) {
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        let frameImage = FrameImage(frameType: frameType, image: image.pngData())
        dataManager.updateData(data: workoutDoneData) { updatedData in
            updatedData.frameImage = frameImage
        }
    }
    
    ///id값으로 데이터가 있는지 판별
    func validFrameImageData(id : Int) -> Bool {
        let selectedBodyInfoData = readWorkoutDoneData(id: id)
        return selectedBodyInfoData?.frameImage == nil ? false : true
    }
    func validWorkoutDoneData(id : Int) -> Bool {
        let selectedWorkoutDoneData = readWorkoutDoneData(id: id)
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
        
        let inputData = Driver<Void>.combineLatest(input.selectedPhoto, input.selectedFrameType, input.selectedDate, input.saveButtonTapped, resultSelector: { (image, frame, id, _) in
            let convertData = self.convertIDToDateString(dateInt: id)
            guard let dateValue = convertData else { return }
            ///데이터가 존재하는 경우
            if self.validWorkoutDoneData(id: id) {
                ///FrameImage 데이터 존재하는 경우 - update
                if self.validFrameImageData(id: id) {
                    print("FrameImage 데이터 존재하는 경우 - update")
                    guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
                    self.dataManager.updateData(data: workoutDoneData) { updatedData in
                        updatedData.frameImage?.image = image.pngData()
                        updatedData.frameImage?.frameType = frame
                    }
                }
                ///FrameImage 데이터 존재하는 않는 경우 - create
                else {
                    print("FrameImage 데이터 존재하는 않는 경우 - create")
                    guard let workoutDoneData = self.readWorkoutDoneData(id: id) else { return }
                    let frameImage = FrameImage(frameType: frame, image: image.pngData())
                    self.dataManager.updateData(data: workoutDoneData) { updatedData in
                        updatedData.frameImage = frameImage
                    }
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
        })

        
        return Output(
            saveButtonStatus: input.frameTypeButtonStatus,
            saveData: inputData)
    }
}
