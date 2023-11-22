//
//  ContentView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import SwiftUI

//struct ContentView: View {
//  @ObservedObject var userRepository = UserRepository()
//  @ObservedObject var eventRepository = EventRepository()
//  @ObservedObject var availabilityRepository = AvailabilityRepository()
//  
//  
//  //  NewEventView //
//  
//    var body: some View {
//      let user = userRepository.getByID("8yNDXAvEKcxEZCDUu74A")
//  
//      if let unwrappedUser = user {
//        let userViewModel = UserViewModel(user: unwrappedUser)
//        NewEventView(userViewModel: userViewModel, currentUser: unwrappedUser)
//      }
//    }
  
  
  //  ScheduledEventsView //
  
  //  var body: some View {
  //      let users = userRepository.users.sorted()
  //      let events = eventRepository.events.sorted()
  //
  //      if let user = users.first {
  //        ScheduledEventsView(user: user)
  //      }
  //    }
//  var body: some View {
//    let user = userRepository.getByID("8yNDXAvEKcxEZCDUu74A")
//    
//    if let unwrappedUser = user {
//      ScheduledEventsView(user: unwrappedUser)
//    }
//  }
  
  //  EventDetialsView //
  
  //  var body: some View {
  //      let event = eventRepository.getByID("H9cCp7JrENa0s4E5djzn")
  //
  //      if let unwrappedEvent = event {
  //        EventDetailsView(event: unwrappedEvent)
  //      }
  //    }
  //
import SwiftUI
struct ContentView: View {
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var eventRepository = EventRepository()
  @ObservedObject var availabilityRepository = AvailabilityRepository()
  
  var body: some View {
    //let users = userRepository.users.sorted()
    //let events = eventRepository.events.sorted()
    
    if let user = userRepository.getByID("8yNDXAvEKcxEZCDUu74A")
       //let event = eventRepository.getByID("7msGh55gCrjdvQClTqov")
    
    {
      //NewEventView(user: user)
      ScheduledEventsView(user: user)
      //EventDetailsView(user: user, event: event)
      //SelectAvailabilityView(user: user, event: event)
      //PeopleTimesView(event: event)
    }
    
  }
}

#Preview {
    ContentView()
}
