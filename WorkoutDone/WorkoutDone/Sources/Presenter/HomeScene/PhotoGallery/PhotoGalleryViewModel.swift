//
//  PhotoGalleryViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/04/22.
//

import UIKit
import RxCocoa
import RxSwift
import Photos


class PhotoGalleryViewModel : ViewModelType {
    
    struct Input {
        let selectedPhotoStatus : Driver<Bool>
    }
    struct Output{
        let nextButtonStatus : Driver<Bool>
    }

    
    func transform(input: Input) -> Output {
        let buttonEnabled = input.selectedPhotoStatus
        return Output(nextButtonStatus: buttonEnabled)
    }
}
