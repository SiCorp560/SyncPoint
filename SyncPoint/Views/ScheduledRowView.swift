//
//  ScheduledRow.swift
//  SyncPoint
//
//  Created by Ammar Raza on 05/11/2023.
//

import SwiftUI

struct ScheduledRowView: View {
    @ObservedObject var availabilityRepository = AvailabilityRepository()
    var event: Event
    let calendar = Calendar.current

  var body: some View {
          
    HStack(alignment: .top) {
              
      VStack(alignment: .leading, spacing: 10) {
                  
                // Final meeting date
                HStack{
                  Image(systemName: "calendar")
                  
                  Text(event.final_meeting_start?.formatted(date: .abbreviated, time: .omitted) ?? "TBD")
                    .font(.caption)
                    .foregroundColor(.black)
                }
                
                HStack {
                Image(systemName: "clock")
                  .foregroundColor(.black)
                
                //Text(event.final_meeting_time["start"]?.formatted(date: .abbreviated, time: .omitted) ?? "TBD")
                Text("TBD")
                  .font(.caption)
                  .foregroundColor(.black)
                }


                
              }

          

      VStack (alignment: .leading, spacing: 10) {
        
        // Event name
        Text(event.name)
          .frame(maxWidth: .infinity, alignment: .leading)
          .fontWeight(.bold)
          .foregroundColor(.black)
        
        // Number of participants filled
          Text("\(availabilityRepository.getByEvent(event.id!).filter { $0.indicated }.count)/\(event.participants.count) Filled")
              .font(.footnote)
              .foregroundColor(.black)
        
    
                  
        // Participants
          HStack {
            ForEach(0..<min(event.participants.count, 4), id: \.self) { _ in
              Image(systemName: "person")
                .foregroundColor(.black)
            }
            if event.participants.count > 4 {
              Text("+ \(event.participants.count - 4) more")
                .foregroundColor(.black)
            }
          }.frame(maxWidth: .infinity, alignment: .leading)
        }
      

      // Details and Edit Button
          VStack {
              HStack(spacing: 12) {
                  // Info button
                  Button(action: {}) {
                      Image(systemName: "info.circle")
                          .foregroundColor(.black)
                  }
                  // Edit button
                  Button(action: {}) {
                      Image(systemName: "pencil")
                          .foregroundColor(.black)
                  }
              }
          }
          }
    
          .padding()
          .background(Color.green.opacity(0.1))
          .cornerRadius(10)
          .overlay(
              RoundedRectangle(cornerRadius: 10)
                  .stroke(Color.green, lineWidth: 2)
          )
          
      }
}
    

