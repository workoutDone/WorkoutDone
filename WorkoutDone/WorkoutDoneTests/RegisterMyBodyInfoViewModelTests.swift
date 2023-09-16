//
//  RegisterMyBodyInfoViewModelTests.swift
//  WorkoutDoneTests
//
//  Created by 류창휘 on 2023/08/29.
//

import XCTest
import RealmSwift
import RxCocoa
@testable import WorkoutDone

final class RegisterMyBodyInfoViewModelTests: XCTestCase {
    // Arrange
    var sut: RegisterMyBodyInfoViewModel!
    
    override func setUp() {
        sut = RegisterMyBodyInfoViewModel()
    }
    override func tearDown() {
        sut = nil
    }
    
    // MARK: - 신체 정보 데이터 입력 가능 범위 체크 테스트
    func testCheckValidInputData_WhenGivenValidData_ReturnTrue() {
        // Given
        // 몸무게
        let weightValue: Double = 80
        // 골격근량
        let skeletalMusleMassValue: Double = 40
        // 체지방량
        let fatPercentage: Double = 20
        
        // When
        let isInputDataValid = sut.checkValidInputData(weight: weightValue, skeletalMusleMass: skeletalMusleMassValue, fatPercentage: fatPercentage)
        
        // Then
        XCTAssertTrue(isInputDataValid, "The isInputDataValid() should have returned TRUE for a valid input Data but returned FALSE")
    }
    
    func testCheckValidInputData_WhenGiveninValidData_ReturnFalse() {

        // Given
        // 몸무게
        let weightValue: Double = 200
        // 골격근량
        let skeletalMusleMassValue: Double = 40
        // 체지방량
        let fatPercentage: Double = 110
        
        // When
        let isInputDataValid = sut.checkValidInputData(weight: weightValue, skeletalMusleMass: skeletalMusleMassValue, fatPercentage: fatPercentage)
        
        // Then
        XCTAssertFalse(isInputDataValid, "The isInputDataValid() should have returned FLASE for a input Data but returned TRUE")
    }
    
    // MARK: - "yyyyMMdd"를 "yyyy.MM.dd"로 변환하는 메서드 체크 테스트
    func testConvertIDToDateString_WhenGivenValidInt_ReturnOptionalString() {
        
        // Given
        // 날짜
        let dateInt = 20230917
        let expectedDateString = "2023.09.17"
        
        // When
        let isInputDataValid = sut.convertIDToDateString(dateInt: dateInt)
        
        // Then
        XCTAssertEqual(isInputDataValid, expectedDateString, "The convertIDToDateString() should have EQUAL but return NIL")
        
    }
    
    func testConvertIDToDateString_WhenGivenInValidInt_ReturnNil() {
        
        // Given
        // 날짜
        let dateInt = 20239999
        
        // When
        let isInputDataInValid = sut.convertIDToDateString(dateInt: dateInt)
        
        // Then
        XCTAssertNil(isInputDataInValid, "The convertIDToDateString() should have NIL but return OptionalString")
        
    }

}
