//
//  UITextField.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/13.
//

import UIKit

extension UITextField {
  func addRightPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.rightView = paddingView
    self.rightViewMode = ViewMode.always
  }
    func addLeftPadding() {
      let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
      self.leftView = paddingView
      self.leftViewMode = ViewMode.always
    }
}
