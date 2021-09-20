//
//  ModelTests.swift
//  RevisadinhoTests
//
//  Created by Hiago Chagas on 15/09/21.
// swiftlint:disable line_length

import XCTest
@testable import Revisadinho

class ModelTests: XCTestCase {
    var sut: Model!
    var coreDataStack: CoreDataTestStack!
    var dba: DatabaseController!
    override func setUp() {
        super.setUp()
        dba = DatabaseController.shared
        coreDataStack = CoreDataTestStack()
        sut = Model.shared
    }

    func test_createMaintenance_shouldNotBeNil() {
        let uuid: UUID = UUID()
        let date: Date = Date()
        let hodometer: Double = 20.876
        let maintenanceItens: [Double] = [1.0, 2.0, 3.0, 4.0]
        let maintenance = sut.createMaintenance(uuid: uuid, date: date, hodometer: hodometer, maintenanceItens: maintenanceItens, viewContext: coreDataStack.viewContext)
        XCTAssertNotNil(maintenance)
    }

    func test_deleteMaintenance_shouldReturnTrue() {
        let uuid: UUID = UUID()
        let date: Date = Date()
        let hodometer: Double = 20.876
        let maintenanceItens: [Double] = [1.0, 2.0, 3.0, 4.0]
        _ = sut.createMaintenance(uuid: uuid, date: date, hodometer: hodometer, maintenanceItens: maintenanceItens, viewContext: coreDataStack.viewContext)
        let result = sut.deleteMaintenance(byUUID: uuid, viewContext: coreDataStack.viewContext)
        XCTAssertTrue(result)
    }

    func test_getMaintenanceByUUID_shouldNotBeNil() {
        let uuid: UUID = UUID()
        let date: Date = Date()
        let hodometer: Double = 20.876
        let maintenanceItens: [Double] = [1.0, 2.0, 3.0, 4.0]
        _ = sut.createMaintenance(uuid: uuid, date: date, hodometer: hodometer, maintenanceItens: maintenanceItens, viewContext: coreDataStack.viewContext)
        let result = sut.getMaintenances(byUUID: uuid, viewContext: coreDataStack.viewContext)
        XCTAssertNotNil(result)
    }

    func test_getMaintenanceByDateInterval_shouldNotBeEmpty() {
        let uuid: UUID = UUID()
        let date: Date = Date()
        let hodometer: Double = 20.876
        let maintenanceItens: [Double] = [1.0, 2.0, 3.0, 4.0]
        _ = sut.createMaintenance(uuid: uuid, date: date, hodometer: hodometer, maintenanceItens: maintenanceItens, viewContext: coreDataStack.viewContext)
        _ = sut.createMaintenance(date: date + 1, hodometer: hodometer, maintenanceItens: maintenanceItens, viewContext: coreDataStack.viewContext)
        let result = sut.getMaintenances(byStartDate: date, toDate: date + 1, viewContext: coreDataStack.viewContext)
        XCTAssertEqual(result.count, 2)
    }

    func test_updateMaintenance_shouldNotBeEqualAfterChange() {
        let uuid: UUID = UUID()
        let date: Date = Date()
        let hodometer: Double = 20.876
        let maintenanceItens: [Double] = [1.0, 2.0, 3.0, 4.0]
        _ = sut.createMaintenance(uuid: uuid, date: date, hodometer: hodometer, maintenanceItens: maintenanceItens, viewContext: coreDataStack.viewContext)
        let updatedMaintenance = sut.updateMaintenance(byUUID: uuid, date: date + 1, hodometer: hodometer + 1.0, maintenanceItens: maintenanceItens + [5.0], viewContext: coreDataStack.viewContext)
        XCTAssertEqual(uuid, updatedMaintenance?.id)
        XCTAssertNotEqual(date, updatedMaintenance?.date)
        XCTAssertNotEqual(hodometer, updatedMaintenance?.hodometer)
        XCTAssertNotEqual(maintenanceItens, updatedMaintenance?.maintenances)

    }
}
