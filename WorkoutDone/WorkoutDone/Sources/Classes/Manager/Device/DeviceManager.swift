//
//  DeviceManager.swift
//  WorkoutDone
//
//  Created by 류창휘 on 2023/03/07.
//

import DeviceKit

public enum DeviceGroup {
    case homeButtonDevice
    case simulatorHomeButtonDevice
    public var rawValue : [Device] {
        switch self {
        case .homeButtonDevice:
            return [.iPhone7, .iPhone8, .iPhone8Plus, .iPhoneSE2, .iPhoneSE3]
        case .simulatorHomeButtonDevice:
            return [.simulator(.iPhoneSE3), .simulator(.iPhoneSE2), .simulator(.iPhone7), .simulator(.iPhone8), .simulator(.iPhone8Plus)]
        }
    }
}

class DeviceManager {
    static let shared : DeviceManager = DeviceManager()
    func isHomeButtonDevice() -> Bool {
        return Device.current.isOneOf(DeviceGroup.homeButtonDevice.rawValue)
    }
    func isSimulatorIsHomeButtonDevice() -> Bool {
        return Device.current.isOneOf(DeviceGroup.simulatorHomeButtonDevice.rawValue)
    }
}
