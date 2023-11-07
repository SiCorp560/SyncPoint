//
//  EventDetailsView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/4/23.
//

import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var userRepository = UserRepository()
    var user: User
    var event: Event
    let calendar = Calendar.current
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Event name
                HStack {
                    Text(event.name)
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(maxWidth: 340, alignment: .leading)
                        .padding()
                        .background(Color.green.opacity(0.3))
                        .cornerRadius(8)
                    Image(systemName: "pencil")
                        .foregroundColor(.black)
                        .padding()
                }
                
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
                    .background(Color.green.opacity(0.3))
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
                
                // MARK: Event description
                Text("Description:")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Text(event.description)
                    .frame(maxWidth: 340, alignment: .leading)
                    .padding()
                    .background(Color.green.opacity(0.3))
                    .cornerRadius(8)
                
                // MARK: Participants
                Text("Participants:")
                    .font(.headline)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                List {
                    ForEach(event.participants.indices) {
                        if let user = userRepository.getByID(self.event.participants[$0]) {
                            Text("\(user.first_name) \(user.last_name)")
                                .frame(width: 55, height: 35, alignment: .center)
                                .padding()
                                .background(
                                    Circle()
                                        .fill(Color.green.opacity(0.3))
                                ).foregroundColor(.black)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
                
                // MARK: Navigation to other features
                NavigationLink(
                    destination: SelectAvailabilityView(user: user, event: event),
                    label: {
                        Text("Select My Availability")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(8)
                  })
                NavigationLink(
                    destination: PeopleTimesView(event: event),
                    label: {
                        Text("View People's Times")
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green.opacity(0.3))
                            .cornerRadius(8)
                  })
                Text("Choose Final Time")
            }
        }
        Spacer()  // To force the content to the top
    }
}
