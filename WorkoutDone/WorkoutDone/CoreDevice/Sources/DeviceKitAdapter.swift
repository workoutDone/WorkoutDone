import DeviceKit

public final class DeviceKitAdapter: DeviceProvider {
    public init() {}
    
    public func isHomeButtonDevice() -> Bool {
        Device.current.isOneOf(DeviceGroup.homeButtonDevice.devices + DeviceGroup.simulatorHomeButtonDevice.devices)
    }
}

private enum DeviceGroup {
    case homeButtonDevice
    case simulatorHomeButtonDevice

    var devices: [Device] {
        switch self {
        case .homeButtonDevice:
            return [.iPhone7, .iPhone8, .iPhone8Plus, .iPhoneSE2, .iPhoneSE3]
        case .simulatorHomeButtonDevice:
            return [
                .simulator(.iPhoneSE3),
                .simulator(.iPhoneSE2),
                .simulator(.iPhone7),
                .simulator(.iPhone8),
                .simulator(.iPhone8Plus)
            ]
        }
    }
}
