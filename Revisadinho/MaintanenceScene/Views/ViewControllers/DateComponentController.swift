//
//  DateComponentController.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 15/09/21.
// swiftlint:disable trailing_whitespace
// swiftlint:disable line_length

import Foundation
import UIKit

class DateComponentController {
    
    static let sharedInstance = DateComponentController()
    let currentDate = DateModel()
    static var lastStateMonth: Int = 0
    static var lastStateYear: Int = 0

    init() {
        DateComponentController.lastStateMonth =  currentDate.getCurrentMonth()
        DateComponentController.lastStateYear =  currentDate.getCurrentYear()
    }
    
    static func getLastStateMonth() -> Int {
        return lastStateMonth
    }
    
    static func getLastStateYear() -> Int {
        return lastStateYear
    }
    
    func calculatesPreviousMonth(currentMonth: Int) -> Int {
        var previousMonth: Int = currentMonth
        if currentMonth == 1 {
            previousMonth = 12
            return previousMonth
        } else {
            previousMonth -= 1
            return previousMonth
        }
    }
    
    func calculatesNextMonth(currentMonth: Int) -> Int {
        var nextMonth: Int = currentMonth
        if currentMonth == 12 {
            nextMonth = 1
            return nextMonth
        } else {
            nextMonth += 1
            return nextMonth
        }
    }
    
    func calculatesNextYear(currentMonth: Int, currentYear: Int) -> Int {
        var nextYear: Int = currentYear
        if currentMonth == 12 {
            nextYear += 1
            return nextYear
        } else {
            return currentYear
        }
    }
    
    func calculatesPreviousYear(currentMonth: Int, currentYear: Int) -> Int {
        var previousYear: Int = currentYear
        if currentMonth == 1 {
            previousYear -= 1
            return previousYear
        } else {
            return currentYear
        }
    }
}

extension DateComponentController: DateComponentActionDelegate {
    func goToPreviousMonth() {
        DateComponentController.lastStateYear = calculatesPreviousYear(currentMonth: DateComponentController.lastStateMonth, currentYear: DateComponentController.lastStateYear)
        DateComponentController.lastStateMonth = calculatesPreviousMonth(currentMonth: DateComponentController.lastStateMonth)
        DateComponent.dateComponent.yearLabel.text = String(DateComponentController.lastStateYear)
        DateComponent.dateComponent.monthLabel.text = currentDate.convertMonthIntToString(monthInt: DateComponentController.lastStateMonth)
    }
    
    func goToNextMonth() {
        DateComponentController.lastStateYear = calculatesNextYear(currentMonth: DateComponentController.lastStateMonth, currentYear: DateComponentController.lastStateYear)
        DateComponentController.lastStateMonth = calculatesNextMonth(currentMonth: DateComponentController.lastStateMonth)
        DateComponent.dateComponent.yearLabel.text = String(DateComponentController.lastStateYear)
        DateComponent.dateComponent.monthLabel.text = currentDate.convertMonthIntToString(monthInt: DateComponentController.lastStateMonth)
    }
}
