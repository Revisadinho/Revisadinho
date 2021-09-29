//
//  DateModelTests.swift
//  RevisadinhoTests
//
//  Created by Jhennyfer Rodrigues de Oliveira on 22/09/21.
// swiftlint:disable trailing_whitespace

import Foundation
import XCTest
@testable import Revisadinho

class DateModelTests: XCTestCase {
    
    let sut = DateModel()
    let date = Date()
    let calendar = Calendar.current
    
    func test_getCurrentDay() {
        let expectedCurrentDay = calendar.component(.year, from: date)
        let currentDay = sut.getCurrentDay()
        XCTAssertTrue(currentDay == expectedCurrentDay)
    }
    
    func test_getCurrentMonth() {
        let expectedCurrentMonth = calendar.component(.month, from: date)
        let currentMonth = sut.getCurrentMonth()
        XCTAssertTrue(currentMonth == expectedCurrentMonth)
    }
    
    func test_getCurrentYear() {
        let expectedCurrentYear = calendar.component(.year, from: date)
        let currentYear = sut.getCurrentYear()
        XCTAssertTrue(currentYear == expectedCurrentYear)
    }
    
    func test_convertMonthIntToString() {
        let month = 1
        let monthInString = sut.convertMonthIntToString(monthInt: month)?.lowercased()
        let expectedMonthInString = "janeiro"
        XCTAssertTrue(monthInString == expectedMonthInString)
    }
}
    
