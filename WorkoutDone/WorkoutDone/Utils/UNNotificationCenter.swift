//
//  UNNotificationCenter.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/06/02.
//

import Foundation
import UserNotifications

extension UNUserNotificationCenter {
    func addNotificationRequest(viewController : DuringWorkoutViewController) {
        
        let notificationCentent = UNMutableNotificationContent()
        notificationCentent.title = "야호"
        notificationCentent.body = "야호오오오"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(viewController.currentCountdownSecond), repeats: false)
        let request = UNNotificationRequest(identifier: "LocalNoti", content: notificationCentent, trigger: trigger)
        add(request, withCompletionHandler: nil)
    }
}
