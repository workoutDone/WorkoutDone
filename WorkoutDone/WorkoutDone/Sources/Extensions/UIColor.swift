//
//  UIColor.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/03.
//

import UIKit

extension UIColor {
    static let colorDBDBDB = UIColor(hex: 0xDBDBDB)
    static let color000000 = UIColor(hex: 0x000000)
    static let colorD6C8FF = UIColor(hex: 0xD6C8FF)
    static let color7346F2 = UIColor(hex: 0x7346F2)
    static let color612CF8 = UIColor(hex: 0x612CF8)
    static let color6A16F3 = UIColor(hex: 0x6A16F3)
    static let color561FF3 = UIColor(hex: 0x561FF3)
    static let color7442FF = UIColor(hex: 0x7442FF)
    static let colorF54968 = UIColor(hex: 0xF54968)
    static let colorFFD953 = UIColor(hex: 0xFFD953)
    static let color1ADFDF = UIColor(hex: 0x1ADFDF)
    static let color8E36FF = UIColor(hex: 0x8E36FF)
    static let colorF4EFFF = UIColor(hex: 0xF4EFFF)
    static let colorE9E1FF = UIColor(hex: 0xE9E1FF)
    static let color121212 = UIColor(hex: 0x121212)
    static let color363636 = UIColor(hex: 0x363636)
    static let color5E5E5E = UIColor(hex: 0x5E5E5E)
    static let color929292 = UIColor(hex: 0x929292)
    static let colorCCCCCC = UIColor(hex: 0xCCCCCC)
    static let colorE2E2E2 = UIColor(hex: 0xE2E2E2)
    static let colorF3F3F3 = UIColor(hex: 0xF3F3F3)
    static let colorFFFFFF = UIColor(hex: 0xFFFFFF)
    static let colorF8F6FF = UIColor(hex: 0xF8F6FF)
    static let colorE6E0FF = UIColor(hex: 0xE6E0FF)
    static let colorC884FF = UIColor(hex: 0xC884FF)
    static let colorECE5FF = UIColor(hex: 0xECE5FF)
    static let colorFFEDF0 = UIColor(hex: 0xFFEDF0)
    static let colorC8B4FF = UIColor(hex: 0xC8B4FF)
    static let color3C3C43 = UIColor(hex: 0x3C3C43)
}

extension UIColor {
    /// hex code를 이용하여 정의
    convenience init(hex: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
