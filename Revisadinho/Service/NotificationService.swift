//
//  NotificationService.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 15/10/21.
//  swiftlint:disable line_length

import Foundation
import UserNotifications

class NotificationService {
    public static let shared = NotificationService()

    private var isNotificationPermitted: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "NotificationPermission")
        } set {
            UserDefaults.standard.set(newValue, forKey: "NotificationPermission")
        }
    }

    private var isNotFirstBoot: Bool {
        get {
            return UserDefaults.standard.bool(forKey: "NotificationFirstBoot")
        } set {
            UserDefaults.standard.set(newValue, forKey: "NotificationFirstBoot")
        }
    }

    private var lastMaintenanceHodometerDictionary: [MaintenanceItem: Double] {
        get {
            if let data = UserDefaults.standard.data(forKey: "NotificationLastMaintenanceHodometerDictionary") {
                let dictData = try? PropertyListDecoder().decode([MaintenanceItem: Double].self, from: data)
                return dictData ?? [:]
            }
            return [:]
        } set {
            if let data = try? PropertyListEncoder().encode(newValue) {
                UserDefaults.standard.set(data, forKey: "NotificationLastMaintenanceHodometerDictionary")
            }
        }
    }

    private var lastMaintenanceHodometer: Double {
        get {
            return UserDefaults.standard.double(forKey: "NotificationLastMaintenanceHodometer")
        } set {
            UserDefaults.standard.set(newValue, forKey: "NotificationLastMaintenanceHodometer")
        }
    }

    private init() {}

    public func askForPermissions() {
        if !isNotificationPermitted {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
                self.isNotificationPermitted = granted
            }
        }
        if !isNotFirstBoot {
            isNotFirstBoot = true
            setupDictionary()
        }
    }

    private func setupDictionary() {
        var dictionary: [MaintenanceItem: Double] = [:]
        for item in MaintenanceItem.allCases {
            dictionary[item] = 0.0
        }
        lastMaintenanceHodometerDictionary = dictionary
    }

    public func updateLastMaintenanceHodometer(forMaintenanceItems maintenanceItens: [MaintenanceItem], withHodometer hodometer: Double) {
        var itemHodometerDict = lastMaintenanceHodometerDictionary
        maintenanceItens.forEach { item in
            itemHodometerDict[item] = hodometer
        }
        lastMaintenanceHodometerDictionary = itemHodometerDict
        lastMaintenanceHodometer = hodometer
        callHodometerNotifications()
    }

    private func callHodometerNotifications() {
        let itemHodometerDict = lastMaintenanceHodometerDictionary
        let hodometer = lastMaintenanceHodometer
        var maintenanceDueArray: [MaintenanceItem] = []
        itemHodometerDict.forEach({ item in
            if hodometer - item.value >= item.key.maintenanceInterval {
                maintenanceDueArray.append(item.key)
            }
        })
        if maintenanceDueArray.count > 0 {
            setupNotification(withItems: maintenanceDueArray)
        }
    }

    private func setupNotification(withItems items: [MaintenanceItem]) {
        let content = UNMutableNotificationContent()
        content.title = "Hora de fazer sua manutenção!"
        content.body = "Oi! Já passou da hora de fazer a manutenção "
        for itemIndex in 0..<items.count {
            let item = items[itemIndex]
            // only item on the list
            if items.count == 1 {
                content.body.append("no seguinte item: \(item.description)")
                break
            }
            // first item on the list
            if itemIndex == 0 {
                content.body.append("nos seguintes itens: \(item.description)")
                continue
            }
            // last item on the list
            if itemIndex == items.count - 1 {
                content.body.append(" e \(item.description).")
                break
            }
            // all the other items in the middle of the list
            content.body.append(", \(item.description)")
        }
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2 * 60, repeats: false) // the time interval is equal to 2 min
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}
