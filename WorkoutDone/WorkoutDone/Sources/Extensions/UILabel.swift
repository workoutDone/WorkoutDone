//
//  UILabel.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/14.
//

import UIKit

extension UILabel {
    /// 라벨 간격 메서드
    func setLineSpacing(lineHeightMultiple : CGFloat) {
        guard let labelText = self.text else { return }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let stringValue = NSMutableAttributedString(string: labelText)
        stringValue.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, stringValue.length))
        self.attributedText = stringValue
    }
}
