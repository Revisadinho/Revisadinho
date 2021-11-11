//
//  EventKitService.swift
//  Revisadinho
//
//  Created by Hiago Chagas on 09/11/21.
//

import EventKit

class EventKitService {
    static let shared = EventKitService()
    private let store = EKEventStore()
    
    private init() { }
    
    public func insertEventIntoCalendar() {
        guard let calendar = store.defaultCalendarForNewEvents else { return }
        let event = EKEvent(eventStore: store)
        event.title = "This is my test event"
        event.startDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        event.isAllDay = true
        event.endDate = event.startDate
        event.calendar = calendar
        saveEvent(event)
    }
    
    private func saveEvent(_ event: EKEvent) {
        do {
            try store.save(event, span: .thisEvent, commit: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
