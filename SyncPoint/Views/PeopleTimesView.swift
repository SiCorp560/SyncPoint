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
    
    var body: some View {
        NavigationView {
            let startDate = event.earliest_date
            var availabilities = availabilityRepository.getByEvent(event.id!)
            ScrollView {
                VStack {
                    Text("View People's Times")
                        .fontWeight(.bold)
                        .font(.title3)
                        .padding()
                    VStack (alignment: .trailing){
                        HStack {
                            ForEach(0..<7, id: \.self) { day in
                                VStack {
                                    Text(calendar.date(byAdding: .day, value: day, to: startDate)!.formatted(date: .numeric, time: .omitted))
                                }
                            }
                        }
                        ForEach(0..<16, id: \.self) { rowIndex in
                            HStack {
                                Text(calendar.date(byAdding: .minute, value: 30 * rowIndex, to: startDate)!.formatted(date: .omitted, time: .shortened))
                                    .frame(width: 75, alignment: .center)
                                    .padding()
                                Spacer()
                                ForEach(0..<7, id: \.self) { columnIndex in
                                    let currentDate = calendar.date(byAdding: .minute, value: 30 * rowIndex, to: calendar.date(byAdding: .day, value: columnIndex, to: startDate)!)!
                                    let matchedDates = availabilities.filter{$0.times.contains(currentDate)}
                                    Button(action: {
                                        // Toggle the selected state
                                        selectedRow = rowIndex
                                        selectedColumn = columnIndex
                                    }) {
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(matchedDates.count > 0 ? Color.green : Color.gray, lineWidth: 1)
                                            .frame(width: 25, height: 25)
                                            .background(matchedDates.count > 0 ? Color.green.opacity(0.5) : Color.clear)
                                    }
                                }
                            }
                        }
                    }.padding()
                    HStack {
                        let getDate = calendar.date(byAdding: .minute, value: 30 * selectedRow, to: calendar.date(byAdding: .day, value: selectedColumn, to: startDate)!)!
                        let matchedDates = availabilities.filter{$0.times.contains(getDate)}
                        let unmatchedDates = availabilities.filter{!$0.times.contains(getDate)}
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
