//
//  MaintenanceViewControllerTests.swift
//  RevisadinhoTests
//
//  Created by Jhennyfer Rodrigues de Oliveira on 22/09/21.
// swiftlint:disable trailing_whitespace line_length

import Foundation
import XCTest
@testable import Revisadinho

class MaintenanceViewControllerTests: XCTestCase {
    
    let sut = MaintenanceViewController()
    
    func test_formatingDateIntoString() {
        let date = Date()
        let calendar = Calendar.current
        let dateModel = DateModel()
        let day =  String(calendar.component(.day, from: date))
        let month =  calendar.component(.month, from: date)
        let year = String(calendar.component(.year, from: date))
        let monthInString = dateModel.convertMonthIntToString(monthInt: month)
        let finalString: String = day + " " + (monthInString ?? "") + ", " + year
        let maintenances = sut.formatDate(date: date)
        XCTAssertTrue(maintenances == finalString)
    }
    
    func test_calculateNumberOfLinesWhenTheRestOfDivisionIsZero() {
        let numberOfItems = 9
        let numberOfItemsPerLine = 3
        let numberOfLines = sut.calculateNumberOfLines(numberOfItems: numberOfItems, numberOfItemsPerLine: numberOfItemsPerLine)
        let expectedNumberOfLines = 3
        XCTAssertTrue(numberOfLines == expectedNumberOfLines )
    }
    
    func test_calculateNumberOfLinesWhenTheRestOfDivisionIsNotZeroRoundingUp() {
        let numberOfItems = 7
        let numberOfItemsPerLine = 3
        let numberOfLines = sut.calculateNumberOfLines(numberOfItems: numberOfItems, numberOfItemsPerLine: numberOfItemsPerLine)
        let expectedNumberOfLines = 3
        XCTAssertTrue(numberOfLines == expectedNumberOfLines )
    }
    
    func test_calculateSizeOfExpandableCellRealCellSize() {
        let numberOfLines = sut.calculateNumberOfLines(numberOfItems: 9, numberOfItemsPerLine: 3)
        print(numberOfLines)
        let expectedResult = ((120+38)*numberOfLines) + (8+16)*2 + 49
        // using values of the real cell
        let expandedCellSize = sut.calculateSizeOfExpandedCell(numberOfLines: numberOfLines, itemSize: 120, spaceBetweenItems: 38, insetTop: 8, insetBottom: 16)
        print(expandedCellSize)
        XCTAssertTrue(expectedResult == Int(expandedCellSize))
    }
    
    func test_calculateSizeOfExpandableCellFakeCellSize() {
        let numberOfLines = sut.calculateNumberOfLines(numberOfItems: 9, numberOfItemsPerLine: 3)
        let expectedResult = ((150+38)*numberOfLines) + (8+8)*2 + 49
        // using values of a fake cell
        let expandedCellSize = sut.calculateSizeOfExpandedCell(numberOfLines: numberOfLines, itemSize: 150, spaceBetweenItems: 38, insetTop: 8, insetBottom: 8)
        XCTAssertTrue(expectedResult == Int(expandedCellSize))
    }
}
