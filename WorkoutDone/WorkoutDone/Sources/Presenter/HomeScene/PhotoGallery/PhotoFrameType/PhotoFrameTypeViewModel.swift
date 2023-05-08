//
//  PhotoFrameTypeViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/08.
//

import UIKit
import RxCocoa
import RxSwift

class PhotoFrameTypeViewModel {
    let realmManager = RealmManager.shared
    
    struct Input {
        let frameTypeButtonStatus : Driver<Bool>
        let selectedFrameType : Driver<Int>
//        let saveButtonTapped : Driver<FrameImage>
//        let selectedData : Driver<String>
    }
    
    struct Output {
        let saveButtonStatus : Driver<Bool>
//        let saveData : Driver<Void>
    }
    
    func transform(input : Input) -> Output {
        
//        let inputData = Driver<Void>.

        
        return Output(
            saveButtonStatus: input.frameTypeButtonStatus)
    }
}
