//
//  EventViewModel.swift
//  SyncPoint
//
//  Created by Ahmad Hallaq on 11/3/23.
//

import Foundation


class EventViewModel: ObservableObject {
  
  @Published var eventRepository = EventRepository()
  @Published var userResposirty = UserRepository()
  @Published var availabilityRepository = AvailabilityRepository()
  
  func add(_ event: Event, _ participants: [User?]) {
    // add the event to the event respository
    eventRepository.create(event)
    
    // add the event to the tbd events of each participant(including host)
    let users = userResposirty.users
    for participant in participants {
      var user = users.filter { $0 == participant }.first
      user?.tbd_events.append(event.id ?? "-1")
    }
    
    // add availability instances
    addAvailabilityRecords(event, participants)
  }
  
  func addAvailabilityRecords(_ event: Event, _ participants: [User?]) {
    let users = userResposirty.users
    for participant in participants {
      var thisUser = users.filter { $0 == participant }.first
      if let unwrappedUser = thisUser {
        var userID = unwrappedUser.id ?? "-1"
        var availability = Availability(user: userID, event:event.id ?? "-1", times:[], indicated:false)
        availabilityRepository.create(availability)
      }
    }
  }
  
}



