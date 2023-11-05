//
//  NewEventView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//
import SwiftUI

struct NewEventView: View {
  
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var eventViewModel = EventViewModel()
  //var currentUser: User
  
  @State private var name: String = ""
  @State private var description: String = ""
  @State private var earliestDate: Date = Date()
  @State private var latestDate: Date = Date()
  //@State private var participants = [User?]
  //@State private var datespan = ["start": Date(), "end": Date()]
  //@State private var common_times = [Date()]
  
  
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Event Details")
          .foregroundColor(.black))
        {
          
            TextField("Add title", text: $name)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
          
          
            TextField("Add Description", text: $description)
            .padding()
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
        }
        
        Section(header: Text("Select range of possible dates")
          .foregroundColor(.black)) {
          
          DatePicker("Earliest:", selection: $earliestDate, displayedComponents: .date)
              .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
              .background(Color.green.opacity(0.1))
              .cornerRadius(8)
          
          DatePicker("Latest:", selection: $latestDate, displayedComponents: .date)
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            .background(Color.green.opacity(0.1))
            .cornerRadius(8)
        }
        
        
        
        Section (header: Text("Add People").foregroundColor(.black)) {
          Button("Search phone contacts") {
            // Handle the finish action here
          }
          .frame(maxWidth: .infinity, alignment: .center)
          .padding()
          .background(Color.green.opacity(0.1))
          .cornerRadius(8)
          .foregroundColor(.black)
        }
        
        
        Button(action: {}) {
          Text("Finish")
            .foregroundColor(.white)
        }
        .padding()
        .background(Color.green)
        .cornerRadius(15)
        .frame(maxWidth: .infinity, alignment: .center)
        
      }
      .navigationBarTitle("New Event", displayMode: .inline)
    }
  }
  
  //  private func isValidEvent() -> Bool {
  //      if name.isEmpty { return false }
  //      if description.isEmpty { return false }
  //      if participants.isEmpty { return false }
  //      if datespan.isEmpty { return false }
  //      return true
  //    }
  //
  //    private func addEvent() {
  //      // add the event to the events repository
  //      let event = Event(name:name, description: description, participants: participants, datespan:datespan, host: currentUser)
  //      //participants.append(currentUser)
  //      eventViewModel.add(event, participants)
  //    }
  //
  //    private func clearFields() {
  //      name = ""
  //      description = ""
  //      participants = [User?]()
  //      earliestDate = Date()
  //      latestDate = Date()
  //      datespan = ["start": Date(), "end": Date()]
  //    }
  //  }
  
}


struct NewEventView_Previews: PreviewProvider {
  static var previews: some View {
    NewEventView()
  }
}

