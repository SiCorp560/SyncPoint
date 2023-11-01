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
    
    var body: some View {
        let users = userRepository.users.sorted()
        let events = eventRepository.events.sorted()
        
        List {
            ForEach(users) { user in
                Text("\(user.last_name), \(user.first_name)")
            }
        }
        .navigationTitle("Users")
        
        List {
            ForEach(events) { event in
                Text("\(event.name)")
            }
        }
        .navigationTitle("Events")
    }
}

