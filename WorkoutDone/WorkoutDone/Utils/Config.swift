//
//  Config.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/07/28.
//

import Foundation

enum Config {
    enum Keys {
        enum Plist {
            static let facebookKey = "FACEBOOK_APP_KEY"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else { fatalError("plist cannot found.") }
        return dict
    }()
}

extension Config {
    static let facebookKey: String = {
        guard let key = Config.infoDictionary[Keys.Plist.facebookKey] as? String else {
            fatalError("facebookKey is not set in plist for this configuration.")
        }
        return key
    }()
}
