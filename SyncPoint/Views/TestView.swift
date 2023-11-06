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
    @ObservedObject var availabilityRepository = AvailabilityRepository()
    
    var body: some View {
        let users = userRepository.users.sorted()
        let events = eventRepository.events.sorted()
        
        if let user = users.first, let event = events.first {
            SelectAvailabilityView(user: user, event: event)
        }
        
//        ForEach(users) { user in
//            if let unwrapID = user.id {
//                let ID = print(unwrapID)
//            }
//            let lastName = print(user.last_name)
//            let firstName = print(user.first_name)
//            let email = print(user.email)
//            let phone = print(user.phone)
//            
//            let userEvent = user.tbd_events[0]
//            let getEvent = eventRepository.getByID(userEvent)
//            if let z = getEvent {
//                let eventName = print(z.name)
//                let eventDescription = print(z.description)
//                let eventParticipants = print(z.participants)
//                let eventHost = print(z.host)
//            }
//
//            let x = print("+++")
//        }
        
//        Text("NOT FROZEN")
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

