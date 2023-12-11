//
//  ScheduledEventsView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

struct ScheduledEventsView: View {
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  
  @ObservedObject var eventRepository = EventRepository()
  @ObservedObject var eventViewModel = EventViewModel()
  var user: User
  
  var body: some View {
    NavigationView {
      
      ZStack(alignment: .bottomTrailing) {
        
        VStack (alignment: .leading){
          
          
          
          // MARK: "To Be Scheduled" events
          HStack{
            Text("To Be Scheduled")
              .fontWeight(.bold)
              .font(.title3)
              .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
            
            Spacer()
            
            Menu {
              Button(action: authViewModel.signOut) {
                Text("Sign Out")
                  .foregroundColor(.blue) // Set the color to blue
              }
            } label: {
              Image(systemName: "ellipsis").foregroundColor(.green)
            }.padding()
          }
          
          ScrollView {
            VStack {
              ForEach(user.tbd_events) { tbd_event in
                if let event = eventViewModel.eventRepository.getByID(tbd_event) {
                  NavigationLink(destination: EventDetailsView(user: user, event: event)) {
                    ScheduledRowView(user: user, event: event)
                  }
                }
              }
            }.padding()
          }
          
          Divider()
          
          Text("Upcoming")
            .fontWeight(.bold)
            .font(.title3)
            .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
          
          
          ScrollView {
            VStack {
              ForEach(user.upcoming_events) { upcoming_event in
                if let event = eventViewModel.eventRepository.getByID(upcoming_event) {
                  NavigationLink(destination: EventDetailsView(user: user, event: event)) {
                    ScheduledRowView(user: user, event: event)
                  }
                }
              }
            }.padding()
          }
          
        }.padding(.bottom, 50)
        
        // Floating action button
        NavigationLink(
          destination: NewEventView(user: user),
          label: {
            Image(systemName: "plus")
              .font(.title.weight(.semibold))
              .padding()
              .background(Color.green)
              .foregroundColor(.white)
              .clipShape(Circle())
              .shadow(radius: 4, x: 0, y: 4)
              .padding()
          }
        )
      }
    }.onAppear(perform: loadData)
  }
  
  func loadData(){
    print ("updated")
    @ObservedObject var eventRepository = EventRepository()
  }
}
