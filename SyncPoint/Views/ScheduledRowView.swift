//
//  ScheduledRow.swift
//  SyncPoint
//
//  Created by Ammar Raza on 05/11/2023.
//

import SwiftUI

struct ScheduledRowView: View {
    @ObservedObject var availabilityRepository = AvailabilityRepository()
    var user: User
    var event: Event
    let calendar = Calendar.current
    
    var body: some View {
        HStack(alignment: .top) {
            
          
            
          VStack (alignment: .leading, spacing: 10) {
                // MARK: Event name
                Text(event.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                // MARK: Number of participants filled
                Text("\(availabilityRepository.getByEvent(event.id!).filter{$0.indicated}.count)/\(event.participants.count) Filled")
                    .font(.footnote)
                    .foregroundColor(.black)
                
                // MARK: Participants
//                HStack {
//                    ForEach(0..<min(event.participants.count, 4), id: \.self) { _ in
//                        Image(systemName: "person")
//                            .foregroundColor(.black)
//                    }
//                    if event.participants.count > 4 {
//                        Text("+ \(event.participants.count - 4) more")
//                            .foregroundColor(.black)
//                    }
//                }.frame(maxWidth: .infinity, alignment: .leading)
            }
          
          VStack(alignment: .leading, spacing: 10) {
                
                // MARK: Final meeting date and time
                HStack {
                    Image(systemName: "calendar")
                    Text(event.final_meeting_start?.formatted(date: .abbreviated, time: .omitted) ?? "TBD")
                        .font(.caption)
                        .foregroundColor(.black)
                }
                HStack {
                    Image(systemName: "clock")
                    Text(event.final_meeting_start?.formatted(date: .omitted, time: .shortened) ?? "TBD")
                        .font(.caption)
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(10)
    }
}
