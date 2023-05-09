//
//  NotificationCenterManager.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/05/09.
//

import Foundation
import UIKit

class NotificationCenterManager {
    static let shared = NotificationCenterManager()
    private let notificationCenter = NotificationCenter()
    
    private init() {}
    
    func addObserver(_ observer : Any, _ selector : Selector, _ name : NSNotification.Name?, _ object : Any?) {
        NotificationCenter.default.addObserver(observer, selector: selector, name: name, object: object)
    }
    func removeObserver(_ observer : Any, _ name : NSNotification.Name?, _ objecy : Any?) {
        notificationCenter.removeObserver(observer, name: name, object: objecy)
    }
    func post(_ name : NSNotification.Name, _ object : Any?, _ userInto : [AnyHashable : Any]?) {
        NotificationCenter.default.post(name: name, object: object, userInfo: userInto)
    }
}
