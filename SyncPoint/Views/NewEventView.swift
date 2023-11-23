//
//  NewEventView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//
import SwiftUI

struct NewEventView: View {
  
  @State var searchField: String = ""
  @State var displayedUsers = [UserRepository]()
  
  @ObservedObject var eventRepository = EventRepository()
  @ObservedObject var userRepository = UserRepository()
 
  @ObservedObject var eventViewModel = EventViewModel()
  //@ObservedObject var userViewModel: UserViewModel
  
  var user: User
  
  @State var navigateToEventDetails = false
  @State private var name: String = ""
  @State private var description: String = ""
  @State private var earliest_date: Date = Date()
  @State private var participants: [String?] = []
  
  

  var body: some View {
    
      @State var displayedUsers = userRepository.users
      
      let binding = Binding<String>(get: {
          self.searchField
      }, set: {
          self.searchField = $0
//          self.userViewModel.search(searchText: self.searchField)
//          self.displayUsers()
      })
      
      NavigationView {
        
        Form {
          Section(header: Text("Event Details").foregroundColor(.black)) {
            
            TextField("Add title", text: $name)
              .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
              .background(Color.green.opacity(0.1))
              .cornerRadius(8)
            
            
            TextField("Add Description", text: $description)
              .padding()
              .background(Color.green.opacity(0.1))
              .cornerRadius(8)
          }
          
          Section(header: Text("Select range of possible dates").foregroundColor(.black)) {
            DatePicker("Earliest:", selection: $earliest_date, displayedComponents: .date)
              .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
              .background(Color.green.opacity(0.1))
              .cornerRadius(8)
          }
          
          
          
          Section(header: Text("Add Participants").foregroundColor(.black)) {
            
            TextField("Search", text: binding)
              .textFieldStyle(RoundedBorderTextFieldStyle())
            List(displayedUsers) { user in
              Text(user.first_name)
                .onTapGesture {
                  if let userId = user.id {
                    if !participants.contains (userId) {
                      self.participants.append(userId)
                      displayedUsers.removeAll{$0.id == userId}
                      
                    }
                  }
                }
            }
          }
          
          
          Section(header: Text("Participants").foregroundColor(.black)) {
            List(participants.compactMap { $0 }, id: \.self) { userId in
              if let user = userRepository.getByID(userId) {
                Text(user.first_name)
              } else {
                Text("Unknown user")
              }
            }
          }
          
          
          Button("Create Event") {
            addEvent()
          }.padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(15)
            .frame(maxWidth: .infinity, alignment: .center)
        
          
          if self.isValidEvent() {
            Button("Confirm") {
              updateDB()
              clearFields()

            }.padding()
              .foregroundColor(.white)
              .background(Color.green)
              .cornerRadius(15)
              .frame(maxWidth: .infinity, alignment: .center)
          }
          
        }.navigationBarTitle("New Event", displayMode: .inline)
          

      }
    
  }

  
    private func isValidEvent() -> Bool {
        if name.isEmpty { return false }
        if description.isEmpty { return false }
        if participants.isEmpty { return false }
        if earliest_date == nil { return false }
        
        return true
      }
  
    
      private func addEvent() {
        // add the event to the events repository
          var components = Calendar.current.dateComponents([.day], from: earliest_date)
          components.hour = 8
          components.minute = 0
          let setDate = Calendar.current.date(from: components)
          let event = Event(name:name, description: description, participants: participants, earliest_date: setDate!, final_meeting_start: Date(), final_meeting_end: Date(), host: user.id)
          participants.append(user.id)
          eventViewModel.add(event, participants)
      }
  
      private func clearFields() {
        name = ""
        description = ""
        participants = [String?]()
        earliest_date = Date()
      }
  
//      func displayUsers() {
//        if searchField == "" {
//          displayedUsers = userViewModel.users
//        } else {
//          displayedUsers = userViewModel.filteredUsers
//        }
//      }
  
      func updateDB() {
        let event = Event(name:name, description: description, participants: participants, earliest_date: earliest_date, final_meeting_start: Date(), final_meeting_end: Date(), host: user.id)
        eventViewModel.updateDB(event, participants)
    
      }
  
    func removeHost() {
      displayedUsers.removeAll{$0.users[0].id == user.id}
    
    }
  
    }
