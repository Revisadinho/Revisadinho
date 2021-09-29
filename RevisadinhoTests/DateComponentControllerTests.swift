//
//  DateComponentControllerTests.swift
//  RevisadinhoTests
//
//  Created by Jhennyfer Rodrigues de Oliveira on 21/09/21.
// swiftlint:disable trailing_whitespace

import Foundation
import XCTest
@testable import Revisadinho

class DateComponentControllerTests: XCTestCase {
    
    let sut = DateComponentController()
    
    func test_calculatesPreviousMonthWhenCurrentMonthIsNotTheFirstMonth() {
        let lastMonth = 12
        let previousMonth = sut.calculatesPreviousMonth(currentMonth: lastMonth)
        XCTAssertTrue(previousMonth == lastMonth-1)
    }
    
    func test_calculatesPreviousMonthWhenCurrentMonthIsTheFirstMonth() {
        let firstMonth = 1
        let previousMonth = sut.calculatesPreviousMonth(currentMonth: firstMonth)
        XCTAssertTrue(previousMonth == 12)
    }
    
    func test_calculatesNextMonthWhenCurrentMonthIsTheLastMonth() {
        let lastMonth = 12
        let nextMonth = sut.calculatesNextMonth(currentMonth: lastMonth)
        XCTAssertTrue(nextMonth == 1)
    }
    
    func test_calculatesNextMonthWhenCurrentMonthIsNotTheLastMonth() {
        let month = 6
        let nextMonth = sut.calculatesNextMonth(currentMonth: month)
        XCTAssertTrue(nextMonth == month + 1)
    }
    
    func test_calculatesNextYearWhenCurrentMonthIsNotTheLastMonth() {
        let month = 6
        let currentYear = 2021
        let nextYear = sut.calculatesNextYear(currentMonth: month, currentYear: currentYear)
        XCTAssertTrue(nextYear == currentYear)
    }
    
    func test_calculatesNextYearWhenCurrentMonthIsTheLastMonth() {
        let month = 12
        let currentYear = 2021
        let nextExpectedYear = 2022
        let nextYear = sut.calculatesNextYear(currentMonth: month, currentYear: currentYear)
        XCTAssertTrue(nextYear == nextExpectedYear)
    }
    
    func test_calculatesPreviousYearWhenCurrentMonthIsNotTheFirstMonth() {
        let month = 6
        let currentYear = 2021
        let nextYear = sut.calculatesPreviousYear(currentMonth: month, currentYear: currentYear)
        XCTAssertTrue(nextYear == currentYear)
    }
    
    func test_calculatesPreviousYearWhenCurrentMonthIsTheFirstMonth() {
        let month = 1
        let currentYear = 2021
        let previousExpectedYear = 2020
        let nextYear = sut.calculatesPreviousYear(currentMonth: month, currentYear: currentYear)
        XCTAssertTrue(nextYear == previousExpectedYear)
    }
}
