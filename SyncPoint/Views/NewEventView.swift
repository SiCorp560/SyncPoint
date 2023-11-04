//
//  NewEventView.swift
//  SyncPoint
//
//  Created by Ahmad Hallaq on 11/4/23.
//

import SwiftUI

struct NewEventView: View {
  
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var eventViewModel = EventViewModel()
  var currentUser: User
  
  
  @State private var name = ""
  @State private var description = ""
  @State private var participants = [User?]()
  @State private var earliestDate = Date()
  @State private var latestDate = Date()
  @State private var datespan = ["start": Date(), "end": Date()]
  //@State private var common_times = [Date()]
  
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
  
  
  private func isValidEvent() -> Bool {
    if name.isEmpty { return false }
    if description.isEmpty { return false }
    if participants.isEmpty { return false }
    if datespan.isEmpty { return false }
    return true
  }
    
  private func addEvent() {
    // add the event to the events repository
    let event = Event(name:name, description: description, participants: participants, datespan:datespan, host: currentUser)
    participants.append(currentUser)
    eventViewModel.add(event, participants)
  }
  
  private func clearFields() {
    name = ""
    description = ""
    participants = [User?]()
    earliestDate = Date()
    latestDate = Date()
    datespan = ["start": Date(), "end": Date()]
  }
}



//#Preview {
//    NewEventView()
//}
