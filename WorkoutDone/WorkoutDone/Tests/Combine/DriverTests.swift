import XCTest
import Combine
@testable import WorkoutDone

final class DriverTests: XCTestCase {
    private var cancellables = Set<AnyCancellable>()

    override func tearDown() {
        cancellables.removeAll()
        super.tearDown()
    }

    func test_whenCombineLatest_thenEmitsTransformedValue() {
        let expectation = XCTestExpectation(description: "combineLatest emits")
        let left = Driver.just(2)
        let right = Driver.just(3)

        Driver<Any>.combineLatest(left, right, resultSelector: { $0 + $1 })
            .publisher
            .sink { value in
                XCTAssertEqual(value, 5)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_whenZip_thenEmitsPairedValue() {
        let expectation = XCTestExpectation(description: "zip emits")
        let left = Driver.just("A")
        let right = Driver.just("B")

        Driver.zip(left, right, resultSelector: { "\($0)\($1)" })
            .publisher
            .sink { value in
                XCTAssertEqual(value, "AB")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func test_whenDrive_thenInvokesOnMainThread() {
        let expectation = XCTestExpectation(description: "drive delivers")
        let driver = Driver.just("ok")

        driver.drive(onNext: { value in
            XCTAssertTrue(Thread.isMainThread)
            XCTAssertEqual(value, "ok")
            expectation.fulfill()
        })
        .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}
