//
//  EventRowView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/4/23.
//

import SwiftUI

struct EventRowView: View {
    @ObservedObject var availabilityRepository = AvailabilityRepository()
    var event: Event
    let calendar = Calendar.current
    
    var body: some View {
        HStack {
            VStack {
                // MARK: Final meeting date
                if let startDate = event.final_meeting_time["start"] {
                    Text(startDate.formatted(date: .abbreviated, time: .omitted))
                } else {
                    Text("TBD")
                }
                
                // MARK: Number of participants filled
                let availabilities = availabilityRepository.getByEvent(event.id!)
                Text("\(availabilities.filter{$0.indicated == true}.count)/\(event.participants.count) Filled")
                
                Spacer()
            }
            VStack {
                // MARK: Event name
                Text(event.name)
                    .fontWeight(.bold)
                
                // MARK: Final meeting time
                HStack {
                    Image(systemName: "clock")
                    if let startDate = event.final_meeting_time["start"] {
                        Text(startDate.formatted(date: .abbreviated, time: .omitted))
                    } else {
                        Text("TBD")
                    }
                }
                
                // MARK: Participants
                HStack {
                    if event.participants.count > 4 {
                        ForEach(0...3, id: \.self) {_ in
                            Image(systemName: "person")
                        }
                        Text("+ \(event.participants.count - 4) more")
                    } else {
                        ForEach(0...event.participants.count - 1, id: \.self) {_ in
                            Image(systemName: "person")
                        }
                    }
                }
            }
            VStack {
                HStack {
                    // MARK: Buttons and other TBD features
                    Button(action: {}) {
                        Image(systemName: "info.circle")
                    }
                    Button(action: {}) {
                        Image(systemName: "pencil")
                    }
                }
                
                Spacer()
            }
        }
    }
}
