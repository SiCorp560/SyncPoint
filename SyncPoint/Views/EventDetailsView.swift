//
//  EventDetailsView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/4/23.
//

import SwiftUI

struct EventDetailsView: View {
    @ObservedObject var userRepository = UserRepository()
    var event: Event
    let calendar = Calendar.current
    
    var body: some View {
        VStack {
            // MARK: Title and buttons
            HStack {
                Button(action: {}) {
                    Image(systemName: "chevron.left")
                }
                .padding(.leading, 40)
                Spacer()
                Text("Event Details")
                Spacer()
                Button(action: {}) {
                    Image(systemName: "message")
                }
                .padding(.trailing, 40)
            }
            
            // MARK: Event name
            Text(event.name)
                .font(.title)
            
            // MARK: Final meeting date and time
            if let startDate = event.final_meeting_time["start"], let endDate = event.final_meeting_time["end"] {
                let newEndDate = calendar.date(byAdding: .minute, value: 1, to: endDate)!
                HStack{
                    Image(systemName: "calendar")
                    Text(startDate.formatted(date: .abbreviated, time: .omitted))
                }
                HStack{
                    Image(systemName: "clock")
                    Text("\(startDate.formatted(date: .omitted, time: .shortened)) - \(newEndDate.formatted(date: .omitted, time: .shortened))")
                }
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
            Text(event.description)
                .border(Color.black, width: 1)
            
            // MARK: Participants
            Text("Participants")
            List {
                ForEach(event.participants.indices) {
                    if let user = userRepository.getByID(self.event.participants[$0]) {
                        Text("\(user.first_name) \(user.last_name)")
                    }
                }
            }
            
            // MARK: Buttons and other TBD features
            Button(action: {}) {
                Text("Select My Availability")
            }
            Button(action: {}) {
                Text("View People's Times")
            }
            Text("Choose Final Time")
        }
        
        Spacer()  // To force the content to the top
    }
}
