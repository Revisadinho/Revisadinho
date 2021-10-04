//
//  DateModel.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 20/09/21.
// swiftlint:disable line_length

import Foundation

struct DateModel {
    let day: Int
    let month: Int
    let year: Int

    init() {
        let date = Date()
        let calendar = Calendar.current
        self.day = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.year = calendar.component(.year, from: date)
    }
    func getCurrentMonth() -> Int {
        return month
    }
    func getCurrentYear() -> Int {
        return year
    }
    func getCurrentDay() -> Int {
        return day
    }
    func convertMonthIntToString(monthInt: Int) -> String? {
        let dict: [Int: String] = [1: "Janeiro", 2: "Fevereiro", 3: "Março", 4: "Abril", 5: "Maio", 6: "Junho", 7: "Julho", 8: "Agosto", 9: "Setembro", 10: "Outubro", 11: "Novembro", 12: "Dezembro"]
        return dict[monthInt]
    }
}
