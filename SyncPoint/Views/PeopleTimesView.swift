//
//  PeopleTimesView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/6/23.
//

import SwiftUI

struct PeopleTimesView: View {
  @ObservedObject var userRepository = UserRepository()
  @ObservedObject var availabilityRepository = AvailabilityRepository()
  var event: Event
  let calendar = Calendar.current
  
  @State private var selectedRow = 0
  @State private var selectedColumn = 0
  
  @State private var isShowingPopover: Bool = false
  
  var body: some View {
    
    let startDate = event.earliest_date
    let availabilities = availabilityRepository.getByEvent(event.id!)
    NavigationView {
      
      ScrollView {
        
        VStack {
          
          VStack (alignment: .trailing) {
            
            HStack {
              
              ForEach(0..<7, id: \.self) { day in
                
                Text(calendar.date(byAdding: .day, value: day, to: startDate)!
                  .formatted(Date.FormatStyle().day().month()))
                .frame(width: 34, alignment: .center)
                .font(.system(size: 14))
                
              }
            }
            
            
            ForEach(0..<17, id: \.self) { rowIndex in
              
              HStack {
                
                Text(calendar.date(byAdding: .minute, value: 30 * rowIndex, to: startDate)!
                  .formatted(date: .omitted, time:.shortened))
                .font(.system(size: 14))
                .frame(width: 75, alignment: .leading)
                
                Spacer()
                
                ForEach(0..<7, id: \.self) { columnIndex in
                  let matchedDates = availabilities.filter{$0.times[7 * rowIndex + columnIndex]}
                  let ratio = Double(matchedDates.count) / Double(availabilities.count)
                  
                  Button (action: {
                    // Toggle the selected indeces
                    selectedRow = rowIndex
                    selectedColumn = columnIndex
                    isShowingPopover.toggle()
                  }) {
                    RoundedRectangle(cornerRadius: 5)
                      .stroke(matchedDates.count > 0 ? Color.green : Color.gray, lineWidth: 1)
                      .frame(width: 34, height: 34)
                      .background(matchedDates.count > 0 ? Color.green.opacity(0.5 * ratio) : Color.clear)
                    
                  }
                  
                }
                
                
              }
            }
          }.padding()
        }.popover(isPresented: $isShowingPopover) {
          
          HStack {
            let matchedDates = availabilities.filter{$0.times[7 * selectedRow + selectedColumn]}
            let unmatchedDates = availabilities.filter{!$0.times[7 * selectedRow + selectedColumn]}
            
            Spacer()
            
            VStack {
              Text("Available").bold()
              ForEach(matchedDates) { avail in
                let user = userRepository.getByID(avail.user)!
                Text("\(user.first_name) \(user.last_name)")
              }
              Spacer()
            }
            Spacer()
            
            VStack {
              Text("Unavailable").bold()
              ForEach(unmatchedDates) { avail in
                let user = userRepository.getByID(avail.user)!
                Text("\(user.first_name) \(user.last_name)")
              }
              Spacer()
            }
            Spacer()
          }
        }
        
        
        
      }
      
    }.navigationBarTitle("People's Time")
    
    
  }
}

