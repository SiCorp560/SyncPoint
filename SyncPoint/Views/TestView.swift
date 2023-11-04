//
//  TestView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/1/23.
//

import SwiftUI

struct TestView: View {
    @ObservedObject var userRepository = UserRepository()
    @ObservedObject var eventRepository = EventRepository()
    @ObservedObject var availabilityRespository = AvailabilityRepository()
  
    var body: some View {
      let availabilities = availabilityRespository.availabilities
      ForEach(availabilities) { availability in
        let event = print(availability.event)
        let indicated = print(availability.indicated)
        let times = print(availability.times)
        
      }
      let firstUser = userRepository.users[0]
      NewEventView(currentUser:firstUser)
      Text("Hello")

//        let users = userRepository.users.sorted()
//        let events = eventRepository.events.sorted()
//        
//        List {
//            ForEach(users) { user in
//                Text("\(user.last_name), \(user.first_name)")
//            }
//        }
//        .navigationTitle("Users")
//        
//        List {
//            ForEach(events) { event in
//                Text("\(event.name)")
//            }
//        }
//        .navigationTitle("Events")
      
    }
}

