//
//  ContentView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import SwiftUI

struct ContentView: View {
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var eventRepository = EventRepository()
  @ObservedObject var availabilityRepository = AvailabilityRepository()
  
  var body: some View {
    let users = userRepository.users.sorted()
    let events = eventRepository.events.sorted()
    
    if let user = users.first {
      ScheduledEventsView(user: user)
    }
  }
}

#Preview {
    ContentView()
}
