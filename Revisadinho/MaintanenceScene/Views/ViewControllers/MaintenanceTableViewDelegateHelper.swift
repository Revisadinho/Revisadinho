//
//  TableViewDelegateHelper.swift
//  Revisadinho
//
//  Created by Jhennyfer Rodrigues de Oliveira on 17/11/21.
//

import Foundation
import UIKit

extension MaintenanceViewController {
    
    func shakeAnimation(cell: MaintenanceTableViewCell) {
        cell.cardCollectionView.transform = CGAffineTransform(translationX: 20, y: 0)
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            cell.cardCollectionView.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func formatHodometerText(hodometer: Double) -> String {
        let intHodometer = Int(hodometer)
        let stringHodometer = String(intHodometer)
        return stringHodometer + " " + "km"
    }
 
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY/MM/dd"
        let formatedDate = dateFormatter.string(from: date)
        let dateArray = formatedDate.split(separator: "/")
        let year = dateArray[dateArray.count-3]
        guard let month = Int(dateArray[dateArray.count-2]) else { return ""}
        let day = dateArray[dateArray.count-1]
        let monthInWord = DateModel().convertMonthIntToString(monthInt: month)
        let finalFormattedDate: String = day + " " + (monthInWord ?? "") + "," + " " + year
        return finalFormattedDate
    }
    
    func isTableViewEmpty() -> Bool {
        let totalMaintenances = allMaintenances[0].count + allMaintenances[1].count
        if totalMaintenances < 1 {
            return true
        } else {
            return false
        }
    }
    
    func getDataForSection(section: Int) -> Int {
        if section == 0 {
            return allMaintenances[0].count
        } else if section == 1 {
            return allMaintenances[1].count + 1 // plus filter cell
        } else if isTableViewEmpty() {
            return 0
        } else {
            print("No data set for this section.")
            return 0
        }
    }
    
    func calculateNumberOfLines(numberOfItems: Int, numberOfItemsPerLine: Int) -> Int {
        if numberOfItems % numberOfItemsPerLine != 0 {
            return (numberOfItems / 3) + 1
        } else {
            return (numberOfItems / 3)
        }
    }
    
    func calculateSizeOfExpandedCell(numberOfLines: Int, itemSize: Int, spaceBetweenItems: Int, insetTop: Int, insetBottom: Int) -> CGFloat {
        let expandedHeight = ((itemSize + spaceBetweenItems)*numberOfLines) + ((insetTop + insetBottom)*2) + 49
        return CGFloat(expandedHeight)
    } 
}
