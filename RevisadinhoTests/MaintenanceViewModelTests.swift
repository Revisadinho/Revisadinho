//
//  MaintenanceViewModelTests.swift
//  RevisadinhoTests
//
//  Created by Hiago Chagas on 20/09/21.
//  swiftlint:disable line_length

import XCTest
@testable import Revisadinho

class MaintenanceViewModelTests: XCTestCase {
    var sut: MaintenanceViewModel!
    var coreDataStack: CoreDataTestStack!
    var date: Date!

    override func setUp() {
        super.setUp()
        coreDataStack = CoreDataTestStack()
        sut = MaintenanceViewModel()
        date = Date()
        createMaintenances(date)
    }

    func test_getMaintenancesByDate_shouldReturnThreeMaintenances() {
        let count = sut.getMaintenancesByDate(startingDate: date - 5, endingDate: date + 5, viewContext: coreDataStack.viewContext).count
        XCTAssertEqual(3, count)
    }

    func test_getMaintenancesByMonthAndYear_shouldReturnThreeMaintenances() {
        let month = Calendar.current.component(.month, from: date)
        let year = Calendar.current.component(.year, from: date)
        let count = sut.getMaintenances(byMonth: month, andYear: year, viewContext: coreDataStack.viewContext).count
        XCTAssertEqual(3, count)
    }
}
extension MaintenanceViewModelTests {
    func createMaintenances(_ date: Date) {
        let model = Model.shared
        _ = model.createMaintenance(uuid: UUID(), date: date - 5, hodometer: 10000, maintenanceItens: [1.0, 2.0], viewContext: coreDataStack.viewContext)
        _ = model.createMaintenance(uuid: UUID(), date: date, hodometer: 20000, maintenanceItens: [1.0, 2.0, 3.0], viewContext: coreDataStack.viewContext)
        _ = model.createMaintenance(uuid: UUID(), date: date + 5, hodometer: 30000, maintenanceItens: [3.0, 4.0, 6.0], viewContext: coreDataStack.viewContext)
    }
}
