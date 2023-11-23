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
    NavigationView{
      VStack {
        VStack(alignment: .leading) {
          // MARK: "To Be Scheduled" events
          
          HStack {
            
            Text("SYNCPOINT")
              .fontWeight(.bold)
              .font(.title)
            
            Spacer()
            
            NavigationLink(
              destination: NewEventView(user: user),
              label: {
                Image(systemName: "plus")
                  .padding()
                  .foregroundColor(.white)
                  .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                  .font(.title)
                  .background(Circle().fill(Color.green).cornerRadius(15)
                    .frame(width:60, height:60))
                
              })
          }.padding()
          
          
        }
        
        VStack (alignment: .leading, spacing: 10){
          Text("To Be Scheduled")
            .fontWeight(.bold)
            .font(.title3)
          
          List {
            ForEach(user.tbd_events.indices) {
              if let event = eventRepository.getByID(self.user.tbd_events[$0]) {
                NavigationLink(destination: EventDetailsView(user: user, event: event)) {
                  ScheduledRowView(user: user, event: event)
                }
              }
            }
          }
        }.padding()
        
        // MARK: "Upcoming" events
        VStack (alignment: .leading, spacing: 10){
          
          Text("Upcoming")
            .fontWeight(.bold)
            .font(.title3)
            .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
          
          List {
            ForEach(user.upcoming_events.indices) {
              if let event = eventRepository.getByID(self.user.upcoming_events[$0]) {
                NavigationLink(destination: EventDetailsView(user: user, event: event)) {
                  ScheduledRowView(user: user, event: event)
                }
              }
            }
          }
        }
        Spacer()
      }
    }.onAppear(perform: loadData)
  }
  
  func loadData(){
    print ("updated")
    @ObservedObject var eventRepository = EventRepository()
  }
}
