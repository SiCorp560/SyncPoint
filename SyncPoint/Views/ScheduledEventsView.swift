//
//  ScheduledEventsView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI


struct ScheduledEventsView: View {
    @ObservedObject var eventRepository = EventRepository()
    var user: User
    
  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        Text("To be Scheduled Events")
          .fontWeight(.bold)
          .font(.title3)
        Spacer()
        
        Button(action: {}) {
          Text("+")
            .foregroundColor(.white)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            .font(.title)
        }
        .padding()
        .background(
          Circle()
            .fill(Color.green)
            .cornerRadius(20))
        
      }.padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
      
      List {
        ForEach(user.tbd_events.indices) {
          if let event = eventRepository.getByID(self.user.tbd_events[$0]) {
            ScheduledRowView(event: event)
          }
        }
      }
      
      
      
      Text("Upcoming Events")
        .fontWeight(.bold)
        .font(.title3)
        .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
      
      
      
      
      List {
        ForEach(user.upcoming_events.indices) {
          if let event = eventRepository.getByID(self.user.upcoming_events[$0]) {
            ScheduledRowView(event: event)
          }
        }
      }
      
      Spacer()
    }
  }
}

