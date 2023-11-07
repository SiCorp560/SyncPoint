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
    print("----")
    print("events before")
    print(eventRepository.events)
    eventRepository.create(event)
    //print(newEvent)
    // add the event to the tbd events of each participant(including host)
    //print(participants)
    var newParticipants = participants.compactMap { $0 }
    //print(newParticipants)
    let users = userResposirty.users
    let events = eventRepository.events
    print("----")
    print("events after")
    print(events)
//    for e in events {
//      print(e)
//      print("----")
//    }
    for participant in newParticipants {
      //print("yesssss")
      var user = users.filter { $0.id == participant }.first
      //print(user?.first_name)
      //print(user)
      //user?.tbd_events.append("yesss")
      //print(event.name)
      var thisEvent = events.filter { $0.name == event.name }.first
      user?.tbd_events.append(thisEvent?.name ?? "-1")
      userResposirty.update(user!)
    }
    
    // add availability instances
    addAvailabilityRecords(event, participants)
  }
  
  func addAvailabilityRecords(_ event: Event, _ participants: [String?]) {
    let users = userResposirty.users
    for participant in participants {
      var thisUser = users.filter { $0.id == participant }.first
      if let unwrappedUser = thisUser {
        var userID = unwrappedUser.id ?? "-1"
        var availability = Availability(user: userID, event:event.id ?? "-1", times:[], indicated:false)
        availabilityRepository.create(availability)
      }
    }
  }
  
}



