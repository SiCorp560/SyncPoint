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
        VStack(alignment: .leading) {
            // MARK: "To Be Scheduled" events
            HStack {
                Text("To Be Scheduled")
                    .fontWeight(.bold)
                    .font(.title3)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.title)
                }
                .padding()
                .background(
                    Circle()
                        .fill(Color.green)
                        .cornerRadius(20)
                )
            }.padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
            List {
                ForEach(user.tbd_events.indices) {
                    if let event = eventRepository.getByID(self.user.tbd_events[$0]) {
                        NavigationLink(destination: EventDetailsView(user: user, event: event)) {
                            EventRowView(user: user, event: event)
                        }
                    }
                }
            }
            
            // MARK: "Upcoming" events
            Text("Upcoming")
                .fontWeight(.bold)
                .font(.title3)
                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
            List {
                ForEach(user.upcoming_events.indices) {
                    if let event = eventRepository.getByID(self.user.upcoming_events[$0]) {
                        NavigationLink(destination: EventDetailsView(user: user, event: event)) {
                            EventRowView(user: user, event: event)
                        }
                    }
                }
            }
            
            Spacer()
        }
    }
}
