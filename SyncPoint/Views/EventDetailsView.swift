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
    @ObservedObject var availabilityRepository = AvailabilityRepository()
  
    @ObservedObject var eventViewModel = EventViewModel()

    var user: User
    var event: Event
    let calendar = Calendar.current
  
    @State private var final_meeting_start = Date()
    @State private var final_meeting_end = Date()

  

    
    var body: some View {
        NavigationView{
          ScrollView{
            VStack {
              // MARK: Title and edit
              HStack(alignment: .center){
                Text("Event Details")
                    .fontWeight(.bold)
                    .font(.title3)
                    .padding()
                if event.host == user.id! {
                  NavigationLink(
                    destination: EditEventView(user: user, event: event),
                    label: {
                      Image(systemName: "pencil")
                        .font(.title3)
                    })
                }
              }

              // MARK: Event name
              
              Text("Event Name:")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
              
              Text(event.name)
                .fontWeight(.bold)
                .font(.title2)
                .frame(maxWidth: 340, alignment: .leading)
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
              
              
              Spacer()
              // MARK: Final meeting date and time
              Text("Date and Time:")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
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
              } else {
                HStack{
                  Image(systemName: "calendar")
                  Text("TBD")
                }
                HStack{
                  Image(systemName: "clock")
                  Text("TBD")
                }
              }
              
              Spacer()
              // MARK: Event description
              Text("Description:")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
              Text(event.description)
                .frame(maxWidth: 340, alignment: .leading)
                .padding()
                .background(Color.green.opacity(0.2))
                .cornerRadius(8)
              
              Spacer()
              // MARK: Participants
              Text("Participants:")
                .font(.headline)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
              
              HStack{
                ForEach(event.participants.indices) {
                  if let user = userRepository.getByID(self.event.participants[$0]!) {
                    Text("\(user.first_name)")
                      .frame(width: 55, height: 35, alignment: .center)
                      .padding()
                      .background(
                        Circle()
                          .fill(Color.green.opacity(0.2))
                      ).foregroundColor(.black)
                  }
                }
              }.frame(maxWidth: .infinity, alignment: .leading)
              
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
                        .cornerRadius(8)
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
                        .cornerRadius(8)
                    })
                }
              }.padding()
              
              Spacer()
              if user.id! == event.host {
                
                if readyToPick() == true {
                  if event.final_meeting_start == nil {
                    
                    
                    Text("Choose Final Time:")
                      .font(.headline)
                      .foregroundColor(.black)
                      .frame(maxWidth: .infinity, alignment: .leading)
                      .padding()
                    HStack{
                      Text("Select start time:")
                        .opacity(0.3)
                      DatePicker("", selection: $final_meeting_start)
                    }.padding()
                      .background(Color.gray.opacity(0.1))
                      .cornerRadius(8)
                    HStack{
                      Text("Select end time:")
                        .opacity(0.3)
                      DatePicker("", selection: $final_meeting_end)
                    }.padding()
                      .background(Color.gray.opacity(0.1))
                      .cornerRadius(8)
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
                        .cornerRadius(20)
                    }
                    .padding()
                  }
                }
              }
            }
          }
        }
        Spacer()// To force the content to the top
    }
  
  
  func readyToPick() -> Bool {
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
    //event.final_meeting_start = final_meeting_start
    //event.final_meeting_end = final_meeting_end
    var thisEvent = eventViewModel.eventRepository.getByID(event.id!)
    thisEvent?.final_meeting_start = final_meeting_start
    thisEvent?.final_meeting_end = final_meeting_end
    eventViewModel.eventRepository.update(thisEvent!)

  }
  
  private func updateDB() {
    //var thisEvent = eventViewModel.eventRepository.getByID(event.id!)
    let users = userRepository.users
    for participant in event.participants {
      var user = users.filter { $0.id == participant }.first
      user?.upcoming_events.append(event.id!)
      user?.tbd_events.removeAll{$0 == event.id}
      userRepository.update(user!)
    }
  }
}
