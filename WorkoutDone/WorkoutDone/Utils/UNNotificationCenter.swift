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
        notificationCentent.title = "오운완"
        notificationCentent.body = "휴식시간이 끝났어요! \n조금만 더 힘내서 운동해볼까요?"
        notificationCentent.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(viewController.currentCountdownSecond), repeats: false)
        let request = UNNotificationRequest(identifier: "LocalNoti", content: notificationCentent, trigger: trigger)
        add(request, withCompletionHandler: nil)
    }
}
