//
//  UserDefaultsManager.swift
//  WorkoutDone
//
//  Created by hyemi on 2023/03/08.
//

import Foundation

class UserDefaultsManager {
    enum Key: String {
        case hasOnboarded
        case isMonthlyCalendar
    }
    
    let defaults = UserDefaults.standard
    static let shared = UserDefaultsManager()

    var hasOnboarded: Bool {
        return load(.hasOnboarded) as? Bool ?? false
    }
    
    var isMonthlyCalendar: Bool {
        return load(.isMonthlyCalendar) as? Bool ?? false
    }
    
    func save( value: Any, forkey key: Key) {
        defaults.set(value, forKey: key.rawValue)
    }
    
    func load(_ key: Key) -> Any? {
        switch key {
        case .hasOnboarded:
            return load(key)
        case .isMonthlyCalendar:
            return load(key)
        }
    }
    
    func loadBool(_ key: Key) -> Bool? {
        return defaults.object(forKey: key.rawValue) as? Bool
    }
    
    func remove(_ key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func isFirstTime() -> Bool {
        if defaults.object(forKey: "isFirstTime") == nil {
            defaults.set("No", forKey: "isFirstTime")
            return true
        } else {
            return false
        }
    }
}
