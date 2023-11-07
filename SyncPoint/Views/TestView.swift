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
        //let users = userRepository.users.sorted()
        //let events = eventRepository.events.sorted()
        
        if let user = userRepository.getByID("RwREYBW90nCKFIQBp7PF"), let event = eventRepository.getByID("H9cCp7JrENa0s4E5djzn") {
            ScheduledEventsView(user: user)
            //EventDetailsView(user: user, event: event)
            //SelectAvailabilityView(user: user, event: event)
            //PeopleTimesView(event: event)
        }
    }
}

