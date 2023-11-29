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
  @Published var userRepository = UserRepository()
  @Published var availabilityRepository = AvailabilityRepository()
  
  func add(_ event: Event, _ participants: [String?]) {
    // add the event to the event respository
    eventRepository.create(event)
    
  }
  
  func updateForParticipants(event: Event) {
    eventRepository.update(event)
    
    for participant in event.participants {
      if var user = userRepository.getByID(participant ?? "") {
        if !user.tbd_events.contains(event.id ?? "") {
          user.tbd_events.append(event.id ?? "")
          userRepository.update(user)
        }
      }
      
      if let exists = availabilityRepository.getByBoth(participant ?? "", event.id ?? "") {
      } else {
        var times = Array(repeating: false, count: 7*30)
        var availability = Availability(user: participant ?? "", event: event.id ?? "", times: times, indicated:false)
        availabilityRepository.create(availability)
      }
    }
  }
  
  func updateDB(_ event: Event, _ participants: [String?]) {
    eventRepository.get()
    var newEvents = eventRepository.events
    var thisEvent = newEvents.filter{ $0.name == event.name }.first
    if let eventID = thisEvent?.getID() {
      
      var newParticipants = participants.compactMap { $0 }
      let users = userRepository.users
      for participant in newParticipants {
        var user = users.filter { $0.id == participant }.first
        user?.tbd_events.append(eventID)
        userRepository.update(user!)
      }
      
      for participant in newParticipants {
          var times = Array(repeating: false, count: 7*30)
          var availability = Availability(user: participant, event:eventID, times: times, indicated:false)
        availabilityRepository.create(availability)
      }
      
    }
  }
}


