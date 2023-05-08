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

//typealias PhotoStatusType =

//enum PhotoGalleryAccessStatusType {
//    case notDetermined
//    case restricted
//    case denied
//    case authorized
//    case limited
//}
enum frameType : Int {
    case defaultFrame = 0
    case manUpperFrame = 1
    func getFrameType() -> Int {
        switch self {
        case .defaultFrame:
            return frameType.defaultFrame.rawValue
        case .manUpperFrame:
            return frameType.manUpperFrame.rawValue
        }
    }
}
class PhotoGalleryViewModel : ViewModelType {
    enum PhotoGalleryAccessStatusType : String {
        case notDetermined
        case restricted
        case denied
        case authorized
        case limited
        
        func getStatusType() -> PhotoGalleryAccessStatusType {
            switch self {
            case .notDetermined:
                return PhotoGalleryAccessStatusType.notDetermined
            case .restricted:
                return PhotoGalleryAccessStatusType.restricted
            case .denied:
                return PhotoGalleryAccessStatusType.denied
            case .authorized:
                return PhotoGalleryAccessStatusType.authorized
            case .limited:
                return PhotoGalleryAccessStatusType.limited
            }
        }
    }
    
    struct Input {
        let loadView : Driver<Void>
        let selectedPhotoStatus : Driver<Bool>
//        let selectedImage : Driver<UIImage>
    }
    struct Output{
        let photoAuthority : Driver<PhotoGalleryAccessStatusType>
        let nextButtonStatus : Driver<Bool>
    }
    func requestPhotoAccessStatus() -> PhotoGalleryAccessStatusType {

        PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
            switch status {
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .authorized:
                print("authorized")
            case .limited:
                print("limited")
            @unknown default:
                print("default")
            }
        }
        return PhotoGalleryAccessStatusType.authorized
    }
    
    func transform(input: Input) -> Output {
        let photoAuth = input.loadView.map { _ in
            return self.requestPhotoAccessStatus()
        }
        let buttonEnabled = input.selectedPhotoStatus
        return Output(photoAuthority: photoAuth,
                      nextButtonStatus: buttonEnabled)
    }
}
//        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
//        switch photoAuthorizationStatus {
//        case .notDetermined:
//            ///The user hasn’t set the app’s authorization status.
//            return .notDetermined
//        case .restricted:
//            ///The app isn’t authorized to access the photo library, and the user can’t grant such permission.
//            return .restricted
//        case .denied:
//            ///The user explicitly denied this app access to the photo library.
//            return .denied
//        case .authorized:
//            ///The user explicitly granted this app access to the photo library.
//            return .authorized
//        case .limited:
//            ///The user authorized this app for limited photo library access.
//            return .limited
//        default:
//            return .notDetermined
//        }
//        var accessStatus: PhotoGalleryAccessStatusType?
