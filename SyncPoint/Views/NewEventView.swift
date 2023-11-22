//
//  NewEventView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//
import SwiftUI

struct NewEventView: View {
  
  //@State var searchField: String = ""
  @State var txt = ""
  //@Binding var data : [UserRepository]
  //@State var displayedUsers = [UserRepository]()
  
  
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
    
    NavigationView {
      
      VStack {
      
      Text("Event Details").bold()
      
      TextField("Add title", text: $name)
        .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .foregroundColor(.black)
        .opacity(3)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
        
      TextField("Add Description", text: $description)
        .padding()
        .foregroundColor(.black)
        .opacity(3)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(8)
      
  
      HStack{
          
        Text("Select Earliest Date:")
          .opacity(0.3)
          
        DatePicker("", selection: $earliest_date, displayedComponents: .date)
            
      }.padding()
      .background(Color.gray.opacity(0.1))
      .cornerRadius(8)

      HStack{
        
        TextField("Search to add participants", text: self.$txt)
          .opacity(3)
          
        
        if self.txt != ""{
          
          Button(action: {
            
            self.txt = ""
            
          }) {
            
            Text("Cancel")
          }
          .foregroundColor(.blue)

        }
        
      }.padding()
       .background(Color.gray.opacity(0.1))
       .cornerRadius(8)
      
      if self.txt != "" {
        if displayedUsers.filter({$0.first_name.lowercased().contains(self.txt.lowercased())}).count == 0 {
          Text("No Results Found").foregroundColor(Color.black.opacity(0.5)).padding()
        } else {
          List(displayedUsers.filter{$0.first_name.lowercased().contains(self.txt.lowercased())}) { displayedUser in
            
            if user.id != displayedUser.id {
              Text(displayedUser.first_name)
                .onTapGesture {
                  if let userId = displayedUser.id {
                    if !participants.contains (userId) {
                      self.participants.append(userId)
                      
                      if !participants.contains(user.id) {
                        participants.append(user.id)
                      }
                      
                    }
                  }
                }
            }
          }.frame(height: UIScreen.main.bounds.height / 5)
        }
        
      }
      
    Text("Participants").bold()
        
      
      List(participants.compactMap { $0 }, id: \.self) { userId in
        
        if let user_ad = userRepository.getByID(userId) {
          
          if user_ad.first_name == user.first_name {
            
            Text("\(user_ad.first_name) (Host)")

          }
          else{
            Text(user_ad.first_name)
          }
          
        } 
        
        else {
          Text("Unknown User")
        }
        
      }.frame(height: UIScreen.main.bounds.height / 5)
      
      Spacer()
      
      if self.isValidEvent() {
        Button("Create Event") {
          
          addEvent()
    
          
        }.padding()
          .foregroundColor(.white)
          .background(Color.green)
          .cornerRadius(15)
          .frame(maxWidth: .infinity, alignment: .center)
      }
      
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
      }.padding()
  }.navigationBarTitle("New Event", displayMode: .inline)
  
  
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
        let event = Event(name:name, description: description, participants: participants, earliest_date: earliest_date, final_meeting_start: nil, final_meeting_end: nil, host: user.id)
        
        eventViewModel.add(event, participants)
      }
  
      private func clearFields() {
        name = ""
        description = ""
        participants = [String?]()
        earliest_date = Date()
      }
  
      func updateDB() {
        let event = Event(name:name, description: description, participants: participants, earliest_date: earliest_date, final_meeting_start: Date(), final_meeting_end: Date(), host: user.id)
        
        eventViewModel.updateDB(event, participants)
    
      }
    }
