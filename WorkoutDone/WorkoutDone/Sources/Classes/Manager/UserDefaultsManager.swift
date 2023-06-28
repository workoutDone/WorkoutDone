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
        case isWorkout
    }
    
    let defaults = UserDefaults.standard
    static let shared = UserDefaultsManager()
    private init() {}
    
    var hasOnboarded: Bool {
        if load(.hasOnboarded) == nil {
            return false
        } else {
            return true
        }
    }
    var isWorkout: Bool {
        if load(.isWorkout) == nil {
            return false
        } else {
            return true
        }
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
            return loadBool(key)
        case .isMonthlyCalendar:
            return loadBool(key)
        case .isWorkout:
            return loadBool(key)
        }
    }
    
    func loadBool(_ key: Key) -> Bool? {
        return defaults.object(forKey: key.rawValue) as? Bool
    }
    
    func remove(_ key: Key) {
        defaults.removeObject(forKey: key.rawValue)
    }
    
    func saveCalendar() {
        if load(.isMonthlyCalendar) == nil {
            save(value: true, forkey: .isMonthlyCalendar)
        } else if (load(.isMonthlyCalendar) as? Bool ?? false) == false {
            save(value: true, forkey: .isMonthlyCalendar)
        } else {
            save(value: false, forkey: .isMonthlyCalendar)
        }
    }
}
