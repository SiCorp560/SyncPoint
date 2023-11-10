//
//  SelectAvailabilityView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI

struct SelectAvailabilityView: View {
    @ObservedObject var availabilityRepository = AvailabilityRepository()
    var user: User
    var event: Event
    let calendar = Calendar.current
    
    @State private var selectedSlots: [[Bool]] = ((Array(repeating: Array(repeating: false, count: 7), count: 16 * 7)))
    
    var body: some View {
        NavigationView {
            let startDate = event.earliest_date
            if var availability = availabilityRepository.getByBoth(user.id!, event.id!) {
                ScrollView {
                    VStack {
                        Text("Select Availability")
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
                                        Button(action: {
                                            // Toggle the selected state
                                            selectedSlots[rowIndex][columnIndex].toggle()
                                        }) {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(selectedSlots[rowIndex][columnIndex] ? Color.green : Color.gray, lineWidth: 1)
                                                .frame(width: 25, height: 25)
                                                .background(selectedSlots[rowIndex][columnIndex] ? Color.green.opacity(0.5) : Color.clear)
                                        }
                                    }
                                }
                            }
                        }.padding()
                        Button(action: {
                            var yesDates: [Date] = Array()
                            for rowIndex in 0..<16 {
                                for columnIndex in 0..<7 {
                                    if selectedSlots[rowIndex][columnIndex] {
                                        let currentDate = calendar.date(byAdding: .minute, value: 30 * rowIndex, to: calendar.date(byAdding: .day, value: columnIndex, to: startDate)!)!
                                        yesDates.append(currentDate)
                                    }
                                }
                            }
                            availability.times = yesDates
                            availabilityRepository.update(availability)
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
