import XCTest
import RealmSwift
@testable import WorkoutDone

struct ExpectedBodyInfoData {
    static let weight: Double = 83
    static let skeletalMusleMass: Double = 40
    static let fatPercentage: Double = 17
    static let date: String = "2023.09.25"
    static let id: Int = 20230925
    
    static let updatedWeight: Double = 75
    static let updatedSkeletalMusleMass: Double = 42
    static let updatedFatPercentage: Double = 12
    static let updatedDate: String = "2023.09.25"
    static let updatedId: Int = 20230925
    
    static let createDate: String = "2023.09.28"
    static let createId: Int = 20230928
}

final class BodyInputDataValidatorTest: XCTestCase {

    var sut: BodyInfoDataManager!
    var realmProvider: MockRealmProvider!
    var testRealm: Realm!
    override func setUp() {
        realmProvider = MockRealmProvider() // Mock Realm을 통해 테스트
        testRealm = try! realmProvider.makeRealm()
        let realmManager = RealmManager(realm: testRealm)
        sut = BodyInfoDataManager(realmManager: realmManager)
        sut.createBodyInfoData(weight: ExpectedBodyInfoData.weight,
                               skeletalMusleMass: ExpectedBodyInfoData.skeletalMusleMass,
                               fatPercentage: ExpectedBodyInfoData.fatPercentage,
                               date: ExpectedBodyInfoData.date,
                               id: ExpectedBodyInfoData.id)
    }
    override func tearDown() {
        sut = nil
        realmProvider = nil
        testRealm = nil
    }
    
    // MARK: - BodyInfoDataManager createBodyInfoData 메서드 테스트
    func testCreateBodyInfoData_WhenGivenData_ShouldCreateBodyInfoDataWithEqualValues() {
        // Given
        let weight: Double = 98.4
        let skeletalMuscleMass: Double = 45.2
        let fatPercentage: Double = 23.5
        // When
        sut.createBodyInfoData(weight: weight,
                               skeletalMusleMass: skeletalMuscleMass, fatPercentage: fatPercentage, date: ExpectedBodyInfoData.createDate, id: ExpectedBodyInfoData.createId)
        // Then
        let savedBodyInfoData = sut.readBodyInfoData(id: ExpectedBodyInfoData.createId)
        XCTAssertEqual(savedBodyInfoData?.weight, weight)
        XCTAssertEqual(savedBodyInfoData?.skeletalMuscleMass, skeletalMuscleMass)
        XCTAssertEqual(savedBodyInfoData?.fatPercentage, fatPercentage)
    }
    
    // MARK: - BodyInfoDataManager readBodyInfoData 메서드 테스트
    func testReadBodyInfoData_WhenBodyInfoDataExist_ShouldReadBodyInfoDataWithEqualValues() {
        // Given
        let expectedWeight = ExpectedBodyInfoData.weight
        let expectedSkeletalMuscleMass = ExpectedBodyInfoData.skeletalMusleMass
        let expectedFatPercentage = ExpectedBodyInfoData.fatPercentage
        let id = ExpectedBodyInfoData.id
        
        // When
        let bodyInfoData = sut.readBodyInfoData(id: id)
        
        // Then
        XCTAssertEqual(bodyInfoData?.weight, expectedWeight)
        XCTAssertEqual(bodyInfoData?.skeletalMuscleMass, expectedSkeletalMuscleMass)
        XCTAssertEqual(bodyInfoData?.fatPercentage, expectedFatPercentage)
    }
    // MARK: - BodyInfoDataManager updateBodyInfoData 메서드 테스트
    func testUpdateBodyInfoData_WhenGivenUpdatedData_ReturnEqual() {
        // Given
        let expectedWeight = ExpectedBodyInfoData.updatedWeight
        let expectedSkeletalMuscleMass = ExpectedBodyInfoData.updatedSkeletalMusleMass
        let expectedFatPercentage = ExpectedBodyInfoData.updatedFatPercentage
        let id = ExpectedBodyInfoData.id
        let date = ExpectedBodyInfoData.date
        let workoutDoneData = WorkOutDoneData(id: id, date: date)
        
        // When
        sut.updateBodyInfoData(workoutDoneData: workoutDoneData,
                                                         weight: expectedWeight,
                                                         skeletalMuscleMass: expectedSkeletalMuscleMass,
                                                         fatPercentage: expectedFatPercentage)
        
        // Then
        XCTAssertEqual(workoutDoneData.bodyInfo?.weight, expectedWeight)
        XCTAssertEqual(workoutDoneData.bodyInfo?.skeletalMuscleMass, expectedSkeletalMuscleMass)
        XCTAssertEqual(workoutDoneData.bodyInfo?.fatPercentage, expectedFatPercentage)
    }
    
}
