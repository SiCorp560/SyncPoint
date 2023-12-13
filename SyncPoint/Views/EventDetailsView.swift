//
//  EventDetailsView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI



struct EventDetailsView: View {
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var eventRepository = EventRepository()
  @ObservedObject var availabilityRepository = AvailabilityRepository()
  
  @ObservedObject var eventViewModel = EventViewModel()
  
  var user: User
  var event: Event
  let calendar = Calendar.current
  
  @State private var final_meeting_start = Date()
  @State private var final_meeting_end = Date()
  


  var body: some View {
    
    ScrollView{
      VStack {
        
        HStack {
          Text("Event Details")
            .font(.title2)
            .fontWeight(.bold)
          
          Spacer()
          
          if event.host == user.id! {
            NavigationLink(
              destination: EditEventView(user: user, event: event),
              label: {
                Text("Edit")
              }
            )
          }
          
          if event.host == user.id! {
            Button("Delete") {
              eventRepository.delete(event)
              self.presentationMode.wrappedValue.dismiss()
              
            }
            .foregroundColor(.red)
          }
        }.padding()
        
        
        
        // MARK: Event name
        
        
        
        Text(event.name)
          .font(.title3)
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.2))
          .cornerRadius(8)
        
        // MARK: Event description
        
        
        Text(event.description)
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.2))
          .cornerRadius(8)
        
        Spacer()
        
        // MARK: Final meeting date and time
        
        
        if let startDate = event.final_meeting_start, let endDate = event.final_meeting_end {
          VStack(alignment: .leading) {
            HStack {
              Image(systemName: "calendar")
              Text(startDate.formatted(date: .abbreviated, time: .omitted))
            }
            HStack {
              Image(systemName: "clock")
              Text("\(startDate.formatted(date: .omitted, time: .shortened)) - \(endDate.formatted(date: .omitted, time: .shortened))")
            }
          }
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.2))
          .cornerRadius(8)
        }
        
        
        else {
          VStack{
            HStack{
              Image(systemName: "calendar")
              Text("TBD")
            }
            HStack{
              Image(systemName: "clock")
              Text("TBD")
            }
          }
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.2))
          .cornerRadius(8)
        }
        
        Spacer()
        
        
        
        // MARK: Participants
        
        ScrollView{
          HStack {
              ForEach(event.participants.indices) { index in
                  if let user = userRepository.getByID(event.participants[index]!) {
                      VStack {
                          Image(systemName: "person.crop.circle.fill")
                          .font(.system(size: 40))
                          .foregroundColor(.green.opacity(0.5))
                          .frame(width: 55, height: 55)
                          .padding(8)
                              

                          Text(user.first_name)
                              .foregroundColor(.black)
                              .frame(width: 55, height: 20, alignment: .center)
                      }
                  }
              }
          }.padding()
          .frame(maxWidth: .infinity, alignment: .leading)
          
        }
        
        Spacer()
        
        HStack{
          // MARK: Navigation to other features
          if let availability = availabilityRepository.getByBoth(user.id ?? "", event.id ?? "") {
            NavigationLink(
              destination: SelectAvailabilityView(user: user, event: event, selectedSlots: availability.times),
              label: {
                Text("Select Availability")
                  .foregroundColor(.white)
                  .padding()
                  .background(Color.green)
                  .cornerRadius(.infinity)
              })
          }
          
          if event.host == user.id! {
            NavigationLink(
              destination: PeopleTimesView(event: event),
              label: {
                Text("View All Times")
                  .foregroundColor(.white)
                  .padding()
                  .background(Color.green)
                  .cornerRadius(.infinity)
              })
          }
        }.padding()
        
        Spacer()
        
        if user.id! == event.host {
          
          if readyToPick() == true {
            if event.final_meeting_start == nil {
              
              VStack{
                
                Text("Choose Final Time:")
                  .font(.headline)
                  .foregroundColor(.black)
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding()
                
                
                HStack{
                  Text("Select start time:") .opacity(0.3)
                  DatePicker("", selection: $final_meeting_start)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                HStack{
                  Text("Select end time:")
                    .opacity(0.3)
                  DatePicker("", selection: $final_meeting_end)
                }.padding()
                  .background(Color.gray.opacity(0.1))
                  .cornerRadius(8)
                
              }.padding()
              
              
              
              Button(action: {
                editFinalTime()
                updateDB()
                self.presentationMode.wrappedValue.dismiss()
              }) {
                Text("Finish")
                  .frame(maxWidth: 100)
                  .padding()
                  .background(Color.green)
                  .foregroundColor(.white)
                  .cornerRadius(.infinity)
              }
              .padding()
            }
          }
        }
      }
    }
    
    Spacer()// To force the content to the top
    
  }

  
  
  private func readyToPick() -> Bool {
    var numberOfIndicated = availabilityRepository.getByEvent(event.id!).filter{$0.indicated}.count
    var numberOfParticipants = event.participants.count
    
    if (numberOfIndicated == numberOfParticipants) {
      return true
    }
    else {
      return false
    }
  }
  
  private func editFinalTime() {
    var thisEvent = eventViewModel.eventRepository.getByID(event.id!)
    thisEvent?.final_meeting_start = final_meeting_start
    thisEvent?.final_meeting_end = final_meeting_end
    eventViewModel.eventRepository.update(thisEvent!)

  }
  
  private func updateDB() {
    let users = userRepository.users
    for participant in event.participants {
      var user = users.filter { $0.id == participant }.first
      user?.upcoming_events.append(event.id!)
      user?.tbd_events.removeAll{$0 == event.id}
      userRepository.update(user!)
    }
  }
}
