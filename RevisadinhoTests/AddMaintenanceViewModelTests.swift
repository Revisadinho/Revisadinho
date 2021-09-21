//
//  AddMaintenanceViewModelTests.swift
//  RevisadinhoTests
//
//  Created by Hiago Chagas on 20/09/21.
//  swiftlint:disable line_length

import XCTest
@testable import Revisadinho

class AddMaintenanceViewModelTests: XCTestCase {
    var sut: AddMaintenanceViewModel!
    var coreDataStack: CoreDataTestStack!
    var date: Date!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        sut = AddMaintenanceViewModel()
        date = Date()
    }

    func test_getMaintenancesByDate_shouldReturnThreeMaintenances() {
        let result = sut.saveMaintenance(hodometer: 10000, date: date, maintenanceItens: [.AirConditioningFilter, .AirFilter])
        XCTAssertTrue(result)
    }
}
