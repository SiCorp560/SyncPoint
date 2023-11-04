//
//  ScheduledEventsView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/4/23.
//

import SwiftUI

struct ScheduledEventsView: View {
    @ObservedObject var eventRepository = EventRepository()
    var user: User
    
    var body: some View {
        // MARK: "To Be Scheduled" events
        HStack {
            Text("To Be Scheduled")
            Button(action: {}) {
                Image(systemName: "plus")
            }
        }
        List {
            ForEach(user.tbd_events.indices) {
                if let event = eventRepository.getByID(self.user.tbd_events[$0]) {
                    EventRowView(event: event)
                }
            }
        }
        
        Text("Upcoming")
        List {
            ForEach(user.upcoming_events.indices) {
                if let event = eventRepository.getByID(self.user.upcoming_events[$0]) {
                    EventRowView(event: event)
                }
            }
        }
    }
}
