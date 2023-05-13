//
//  UIImage.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/12.
//

import UIKit

extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        let size = self.size
        let widthRatio = targetSize.width / size.width
        let heightRatio = targetSize.height / size.height

        let scaleFactor = min(widthRatio, heightRatio)
        let newSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)

        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        }

        return image
    }
}
