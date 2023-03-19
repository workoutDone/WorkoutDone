//
//  PreviewView.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/18.
//

import UIKit
import AVFoundation

class PreviewView : UIView {
    override class var layerClass : AnyClass {
        AVCaptureVideoPreviewLayer.self
    }
    var previewLayer : AVCaptureVideoPreviewLayer {
        guard let layer = layer as? AVCaptureVideoPreviewLayer else { fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer.")}
        layer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        layer.connection?.videoOrientation = .portrait
        return layer
    }
    
    var sesstion : AVCaptureSession? {
        get { previewLayer.session }
        set { previewLayer.session = newValue }
    }
}
