//
//  ContentView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import SwiftUI
struct ContentView: View {
//    @ObservedObject var userRepository = UserRepository()
//    @ObservedObject var eventRepository = EventRepository()
//    @ObservedObject var availabilityRepository = AvailabilityRepository()
    @EnvironmentObject var authViewModel: AuthenticationViewModel
  
    var body: some View {
        switch authViewModel.state {
            case .signedIn: TestHomeView()
            case .signedOut: SignInView()
        }
//        let users = userRepository.users.sorted()
//        let events = eventRepository.events.sorted()
//        
//        if let user = userRepository.getByID("YS3CGe8ESCRrqB6XaWAG"), let event = eventRepository.getByID("H9cCp7JrENa0s4E5djzn") {
//            NewEventView(user: user)
//            ScheduledEventsView(user: user)
//            EventDetailsView(user: user, event: event)
//            SelectAvailabilityView(user: user, event: event)
//            PeopleTimesView(event: event)
//        }
    }
}

#Preview {
    ContentView()
}
