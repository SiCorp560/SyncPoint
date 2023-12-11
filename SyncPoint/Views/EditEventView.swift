//
//  EditEventView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/28/23.
//

import SwiftUI

struct EditEventView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var eventRepository = EventRepository()
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var eventViewModel = EventViewModel()
  
  var user: User
  var event: Event
  
  //@State var navigateToEventDetails = false
  @State var txt = ""
  @State private var name: String = ""
  @State private var description: String = ""
  @State private var participants: [String?] = []
  
  var body: some View {
    @State var displayedUsers = userRepository.users
    
    NavigationView {
      
      VStack(alignment: .leading) {
        

        
        TextField("Title", text: $name)
          .onAppear() {
            self.name = event.name
          }
          .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
          .foregroundColor(.black)
          .opacity(3)
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)
        TextField("Description", text: $description)
          .onAppear() {
            self.description = event.description
          }
          .padding()
          .foregroundColor(.black)
          .opacity(3)
          .background(Color.gray.opacity(0.1))
          .cornerRadius(8)
        
        HStack{
          TextField("Search to add participants", text: self.$txt)
            .opacity(3)
          if self.txt != "" {
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
              if user.id != displayedUser.id && !event.participants.contains(displayedUser.id) {
                Text(displayedUser.first_name)
                  .onTapGesture {
                    if let userId = displayedUser.id {
                      if !participants.contains (userId) {
                        self.participants.append(userId)
                      }
                    }
                  }
              }
            }.frame(height: UIScreen.main.bounds.height / 5)
          }
        }
        
        if participants != [] {
          ScrollView{
            
            VStack (alignment: .leading) {
              
              
              Text("Participants").bold()
              
              Divider()
              ForEach(participants.compactMap { $0 }, id: \.self) { userId in
                if let user_ad = userRepository.getByID(userId) {
                  if user_ad.first_name == user.first_name {
                    Text("\(user_ad.first_name) (Host)")
                  } else {
                    Text(user_ad.first_name)
                  }
                } else {
                  Text("Unknown User")
                }
                Divider()
              }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
          }
        }
        
        Spacer()
        if self.isValidEdit() {
          Button("Confirm") {
            if var changeEvent = eventRepository.getByID(event.id!) {
              changeEvent.name = name
              changeEvent.description = description
              changeEvent.participants.append(contentsOf: participants)
              eventViewModel.updateForParticipants(event: changeEvent)
              self.presentationMode.wrappedValue.dismiss()
            }
          }.padding()
            .foregroundColor(.white)
            .background(Color.green)
            .cornerRadius(.infinity)
            .frame(maxWidth: .infinity, alignment: .center)
        }
      }.padding()
    }.navigationBarTitle("Edit Event", displayMode: .inline)
  }

  private func isValidEdit() -> Bool {
    if name.isEmpty { return false }
    if description.isEmpty { return false }
    return true
  }
}

