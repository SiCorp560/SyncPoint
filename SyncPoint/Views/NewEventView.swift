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
  @State private var participants = [String?]()
  @State private var earliest_date = Date()
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
  
  
  private func isValidEvent() -> Bool {
    if name.isEmpty { return false }
    if description.isEmpty { return false }
    if participants.isEmpty { return false }
    //if earliest_date == nil { return false }
    return true
  }
    
  private func addEvent() {
    // add the event to the events repository
    let event = Event(name:name, description: description, participants: participants, earliest_date:earliest_date, host: currentUser.id)
    participants.append(currentUser.id)
    eventViewModel.add(event, participants)
  }
  
  private func clearFields() {
    name = ""
    description = ""
    participants = [String?]()
    earliest_date = Date()
  }
}



//#Preview {
//    NewEventView()
//}
