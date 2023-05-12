//
//  ImageSelectionViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/12.
//

import RxCocoa
import RxSwift
import RealmSwift

class ImageSelectionViewModel {
    let realm = try! Realm()
    
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
        let selectedBodyInfoData = realm.object(ofType: WorkOutDoneData.self, forPrimaryKey: id)
        return selectedBodyInfoData?.frameImage == nil ? false : true
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
        
        return Output(
            checkFrameImageData: validFrameImageData,
            deleteData: input.loadView)
    }
}
