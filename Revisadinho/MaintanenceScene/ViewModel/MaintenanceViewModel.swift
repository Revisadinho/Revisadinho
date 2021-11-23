//
//  MaintenanceViewModel.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 21/09/21.

import Foundation
import CoreData

class MaintenanceViewModel {
    private let model: Model = Model.shared

    func getMaintenancesByDate(startingDate: Date, endingDate: Date, viewContext: NSManagedObjectContext = DatabaseController.shared.viewContext) -> [Maintenance] {
        var maintenances: [Maintenance] = []
        let maintenancesDAO = model.getMaintenances(byStartDate: startingDate, toDate: endingDate, viewContext: viewContext)
        for maintenance in maintenancesDAO {
            guard let id = maintenance.id else { return []}
            guard let date = maintenance.date else { return []}
            let hodometer = maintenance.hodometer
            let maintenanceItens = maintenance.maintenanceItens?.map { maintenanceItem in
                return MaintenanceItem(rawValue: Int(maintenanceItem))!
            }
            maintenances.append(Maintenance(id: id, hodometer: hodometer, date: date, maintenanceItens: maintenanceItens ?? []))
        }
        return maintenances
    }

    func getMaintenances(byMonth month: Int, andYear year: Int, viewContext: NSManagedObjectContext = DatabaseController.shared.viewContext) -> [Maintenance] {
        var maintenances: [Maintenance] = []
        let maintenancesDAO = model.getMaintenances(byMonth: month, andYear: year, viewContext: viewContext)
        for maintenance in maintenancesDAO {
            guard let id = maintenance.id else { return []}
            guard let date = maintenance.date else { return []}
            let hodometer = maintenance.hodometer
            var maintenanceItens = maintenance.maintenanceItens?.map { maintenanceItem in
                return MaintenanceItem(rawValue: Int(maintenanceItem))!
            }
            maintenanceItens = maintenanceItens?.sorted {
                $0.description.folding(options: .diacriticInsensitive, locale: .current) < $1.description.folding(options: .diacriticInsensitive, locale: .current)
            }
            maintenances.append(Maintenance(id: id, hodometer: hodometer, date: date, maintenanceItens: maintenanceItens ?? []))
        }
        return maintenances
    }
    
    func getAllMaintenances() -> [Maintenance] {
        var maintenances: [Maintenance] = []
        let allMaintenances = model.getMaintenances()
        for maintenance in allMaintenances {
            guard let id = maintenance.id else { return []}
            guard let date = maintenance.date else { return []}
            let hodometer = maintenance.hodometer
            let maintenanceItens = maintenance.maintenanceItens?.map { maintenanceItem in
                return MaintenanceItem(rawValue: Int(maintenanceItem))!
            }
            maintenances.append(Maintenance(id: id, hodometer: hodometer, date: date, maintenanceItens: maintenanceItens ?? []))
        }
        return maintenances
    }
    
    func getFutureMaintenances() -> [Maintenance] {
        var futureMaintenances: [Maintenance] = []
        let maintenances = getAllMaintenances()
        let currentDate = Date()
        for maintenance in maintenances where maintenance.date > currentDate {
            futureMaintenances.append(maintenance)
        }
        return futureMaintenances
    }
    
    func getPastMaintenances() -> [Maintenance] {
        var pastMaintenances: [Maintenance] = []
        let maintenances = getAllMaintenances()
        let currentDate = Date()
        for maintenance in maintenances where maintenance.date < currentDate {
            pastMaintenances.append(maintenance)
        }
        return pastMaintenances
    }
    
    func getFutureAndPastMaintenancesFormattedForTableView() -> [[Maintenance]] {
        let pastMaintenances = getPastMaintenances()
        let futureMaintenances = getFutureMaintenances()
        let futureAndPastMaintenances: [[Maintenance]] = [futureMaintenances, pastMaintenances]
        return futureAndPastMaintenances
    }
    
    func getPastMaintenances(since : FilterOptions) -> [Maintenance] {
        switch since {
        case .always:
            return getPastMaintenances()
        case .sixMonthsAgo:
            let monthAndYear = (calculateMonthAgoAndYearSinceCurrentMonth(monthsAgo: 6))
            guard let month = monthAndYear["month"] else {return []}
            guard let year = monthAndYear["year"] else {return []}
            return getMaintenance(sinceMonth: month, sinceYear: year, quantOfMonthsAgo: 6)
        case .yearAgo:
            let monthAndYear = (calculateMonthAgoAndYearSinceCurrentMonth(monthsAgo: 12))
            guard let month = monthAndYear["month"] else {return []}
            guard let year = monthAndYear["year"] else {return []}
            return getMaintenance(sinceMonth: month, sinceYear: year, quantOfMonthsAgo: 12)
        case .chooseYear:
            return []
        }
    }
    
    func getMaintenance(sinceMonth month: Int, sinceYear year: Int, quantOfMonthsAgo: Int) -> [Maintenance] {
        var maintenances: [Maintenance] = []
        var monthControl = month
        var yearControl = year
        var i = 0
        while i < quantOfMonthsAgo {
            let monthMaintenances = getMaintenances(byMonth: monthControl, andYear: yearControl)
            if monthControl == 12 {
                monthControl = 1
                yearControl = year+1
            } else {
                monthControl += 1
            }
            for maintenance in monthMaintenances {
                if maintenance.date < Date() {
                    maintenances.append(maintenance)
                }
            }
            i += 1
        }
        maintenances.sort { $0.date > $1.date}
        return maintenances
    }
    
    func calculateMonthAgoAndYearSinceCurrentMonth(monthsAgo: Int) -> [String: Int] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        let monthsArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        var newMonthsArray: [Int] = []
        var monthAndYear: [String:Int] = ["month": 0, "year": currentYear]
        
        while newMonthsArray.count < monthsAgo {
            for month in (1...currentMonth).reversed() where newMonthsArray.count < monthsAgo {
                newMonthsArray.append(month)
            }
            if newMonthsArray.count == monthsAgo {
                monthAndYear["month"] = newMonthsArray[monthsAgo-1]
            }
            var descendingSortedMonthsArray: [Int] = monthsArray
            descendingSortedMonthsArray.sort { (lhs: Int, rhs: Int) -> Bool in
                return lhs > rhs
            }
            var index = 0
            while newMonthsArray.count < monthsAgo && index < descendingSortedMonthsArray.count {
                newMonthsArray.append(descendingSortedMonthsArray[index])
                index += 1
                monthAndYear["month"] = newMonthsArray[monthsAgo-1]
                monthAndYear["year"] = currentYear - 1
            }
        }
        return monthAndYear
    }
    
    func getListOfYearsForPicker() -> [Int] {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentYear = calendar.component(.year, from: currentDate)
        var list = [2019, 2020]
        if !list.contains(currentYear) {
            list.append(currentYear)
        }
        list.sort { $0 > $1}
        return list
    }
    
    func getPastMaintenances(year: Int) -> [Maintenance] {
        let pastMaintenances = getPastMaintenances()
        var yearMaintenances: [Maintenance] = []
        for maintenance in pastMaintenances {
            let calendar = Calendar.current
            let maintenanceYear = calendar.component(.year, from: maintenance.date)
            if maintenanceYear == year {
                yearMaintenances.append(maintenance)
            }
        }
        return yearMaintenances
    }
}
