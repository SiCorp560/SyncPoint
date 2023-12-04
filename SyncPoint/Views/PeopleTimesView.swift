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
    
    @State private var isShowingPopover = false
    
    var body: some View {
        NavigationView {
            let startDate = event.earliest_date
            let availabilities = availabilityRepository.getByEvent(event.id!)
            ScrollView {
                
              VStack {
                    Text("View People's Times")
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding()
                    
                  VStack (alignment: .trailing) {
                        
                    HStack {
                      
                      ForEach(0..<7, id: \.self) { day in
                        
                        Text(calendar.date(byAdding: .day, value: day, to: startDate)!
                          .formatted(Date.FormatStyle().day().month()))
                        .font(.system(size: 12))
                        
                      }
                    }
                    
                    
                      ForEach(0..<30, id: \.self) { rowIndex in
                          
                        HStack {
                              
                          Text(calendar.date(byAdding: .minute, value: 30 * rowIndex, to: startDate)!
                          .formatted(date: .omitted, time:.shortened))
                          .frame(width: 75, alignment: .leading)
                          
                            Spacer()
                              
                          ForEach(0..<7, id: \.self) { columnIndex in
                                let matchedDates = availabilities.filter{$0.times[7 * rowIndex + columnIndex]}
                                let ratio = Double(matchedDates.count) / Double(availabilities.count)
                                
                            Button(action: {
                                    // Toggle the selected indeces
                                    selectedRow = rowIndex
                                    selectedColumn = columnIndex
                                    isShowingPopover = true
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
                }
              
              
                .popover(isPresented: $isShowingPopover) {
                    HStack {
                        let matchedDates = availabilities.filter{$0.times[7 * selectedRow + selectedColumn]}
                        let unmatchedDates = availabilities.filter{!$0.times[7 * selectedRow + selectedColumn]}
                        Spacer()
                        VStack {
                            Text("Available")
                            ForEach(matchedDates) { avail in
                                let user = userRepository.getByID(avail.user)!
                                Text("\(user.first_name) \(user.last_name)")
                            }
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Text("Unavailable")
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
        }
    }
}
