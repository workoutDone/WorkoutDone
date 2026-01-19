import XCTest
@testable import CoreDevice

final class CoreDeviceTests: XCTestCase {
    func test_whenHomeButtonDeviceReportedByMock_thenReturnsTrue() {
        let provider = MockDeviceProvider(isHomeButtonDeviceResult: true)

        let result = isHomeButtonDevice(using: provider)

        XCTAssertTrue(result)
        XCTAssertEqual(provider.isHomeButtonDeviceCallCount, 1)
    }

    func test_whenNonHomeButtonDeviceReportedByMock_thenReturnsFalse() {
        let provider = MockDeviceProvider(isHomeButtonDeviceResult: false)

        let result = isHomeButtonDevice(using: provider)

        XCTAssertFalse(result)
        XCTAssertEqual(provider.isHomeButtonDeviceCallCount, 1)
    }
}

private func isHomeButtonDevice(using provider: DeviceProvider) -> Bool {
    provider.isHomeButtonDevice()
}

private final class MockDeviceProvider: DeviceProvider {
    private let isHomeButtonDeviceResult: Bool
    private(set) var isHomeButtonDeviceCallCount = 0

    init(isHomeButtonDeviceResult: Bool) {
        self.isHomeButtonDeviceResult = isHomeButtonDeviceResult
    }

    func isHomeButtonDevice() -> Bool {
        isHomeButtonDeviceCallCount += 1
        return isHomeButtonDeviceResult
    }
}
