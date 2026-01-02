//
//  ImageSelectionViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/12.
//

import RxCocoa
import RxSwift

class ImageSelectionViewModel {
    private let dataManager = SwiftDataManager.shared
    
    struct Input {
        let loadView : Driver<Void>
        let selectedDate : Driver<Int>
        let defaultImageButtonTapped : Driver<Void>
    }
    struct Output {
        let checkFrameImageData : Driver<Bool>
        let deleteData : Driver<Void>
    }
    
    func validFrameImageData(id : Int) -> Bool {
        let selectedBodyInfoData = dataManager.readData(id: id, type: WorkOutDoneData.self)
        return selectedBodyInfoData?.frameImage == nil ? false : true
    }
    
    func deleteFrameImageData(id : Int) {
        guard let workoutDoneData = dataManager.readData(id: id, type: WorkOutDoneData.self),
              let frameImage = workoutDoneData.frameImage else { return }
        dataManager.deleteData(data: frameImage)
    }
    func transform(input : Input) -> Output {
        
        let validFrameImageData = Driver<Bool>.combineLatest(input.loadView, input.selectedDate, resultSelector: { (_, id) in
            if self.validFrameImageData(id: id) {
                return true
            }
            else {
                return false
            }
        })
        
        let deleteData = Driver<Void>.combineLatest(input.selectedDate, input.defaultImageButtonTapped, resultSelector: { [weak self] (id, _) in
            self?.deleteFrameImageData(id: id)
        })
        
        return Output(
            checkFrameImageData: validFrameImageData,
            deleteData: deleteData)
    }
}
