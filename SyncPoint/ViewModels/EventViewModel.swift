//
//  EventViewModel.swift
//  SyncPoint
//
//  Created by Ammar Raza on 05/11/2023.
//
import Foundation
import Firebase


class EventViewModel: ObservableObject {
  
  @Published var eventRepository = EventRepository()
  @Published var userResposirty = UserRepository()
  @Published var availabilityRepository = AvailabilityRepository()
  
  func add(_ event: Event, _ participants: [String?]) {
    // add the event to the event respository
    eventRepository.create(event)
    
  }
  
  func updateDB(_ event: Event, _ participants: [String?]) {
    eventRepository.get()
    var newEvents = eventRepository.events
    var thisEvent = newEvents.filter{ $0.name == event.name }.first
    if let eventID = thisEvent?.getID() {
      
      var newParticipants = participants.compactMap { $0 }
      let users = userResposirty.users
      for participant in newParticipants {
        var user = users.filter { $0.id == participant }.first
        user?.tbd_events.append(eventID)
        userResposirty.update(user!)
      }
      
      for participant in newParticipants {
        var availability = Availability(user: participant, event:eventID, times:[], indicated:false)
        availabilityRepository.create(availability)
      }
      
    }
  }
  
  
  
//  func addAvailabilityRecords(_ event: Event, _ participants: [String?]) {
//    let users = userResposirty.users
//    for participant in participants {
//      var thisUser = users.filter { $0.id == participant }.first
//      if let unwrappedUser = thisUser {
//        var userID = unwrappedUser.id ?? "-1"
//        var availability = Availability(user: userID, event:event.id ?? "-1", times:[], indicated:false)
//        availabilityRepository.create(availability)
//      }
//    }
//  }
  
}


