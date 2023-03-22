//
//  HomeButtonLessCameraViewModel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/21.
//

//import Foundation
//import RxCocoa
//import RxSwift
//import AVFoundation
//
//class HomeButtonLessCameraViewModel {
//    
//    struct Input {
//        let cameraRequestAuth : PublishSubject<Bool>
//    }
//    struct Output {
//        let cameraAuth : PublishSubject<Void>
//    }
//    func transform(input : Input) -> Output {
////        let cameraAuthState = input.cameraRequestAuth.map { _ in
////            AVCaptureDevice.requestAccess(for: .video) { grainted in
////                if grainted {
////                    return true
////                }
////                else {
////                    return false
////                }
////            }
////        }
//        var cameraAuthState = AVCaptureDevice.requestAccess(for: .video) { isGranted in
//            if isGranted {
//                return true
//            }
//            else {
//                return false
//            }
//        }
//        return Output(cameraAuth: input.cameraRequestAuth.onNext(cameraAuthState))
//    }
//}
