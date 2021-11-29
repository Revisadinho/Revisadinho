//
//  EventKitService.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 09/11/21.

import EventKit

class EventKitService {
    static let shared = EventKitService()
    private let store = EKEventStore()

    private init() { }

    public func insertEventIntoCalendar(title: String, services: [MaintenanceItem], date: Date = Date()) {
        store.requestAccess(to: .event) { [weak self] (granted, _) in
            guard let self = self else { return }
            if granted {
                guard let calendar = self.store.defaultCalendarForNewEvents else { return }
                let event = EKEvent(eventStore: self.store)
                event.title = self.buildTitleOfEvent(with: services, for: title)
                event.startDate = date
                event.isAllDay = true
                event.endDate = event.startDate
                event.calendar = calendar
                let alarm = EKAlarm(relativeOffset: TimeInterval(-1 * 60 * 60 * 24))
                event.addAlarm(alarm)
                self.saveEvent(event)
            }
        }
    }
    
    private func buildTitleOfEvent(with items: [MaintenanceItem], for title: String) -> String {
        var result: String = title
        for itemIndex in 0..<items.count {
            let item = items[itemIndex]
            // only item on the list
            if items.count == 1 {
                result.append("no item: \(item.description)")
                break
            }
            // first item on the list
            if itemIndex == 0 {
                result.append("nos itens: \(item.description)")
                continue
            }
            // last item on the list
            if itemIndex == items.count - 1 {
                result.append(" e \(item.description).")
                break
            }
            // all the other items in the middle of the list
            result.append(", \(item.description)")
        }
        return result
    }

    private func saveEvent(_ event: EKEvent) {
        do {
            try store.save(event, span: .thisEvent, commit: true)
        } catch {
            print(error.localizedDescription)
        }
    }

}
