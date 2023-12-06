//
//  SelectAvailabilityView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI

struct SelectAvailabilityView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var userRepository = UserRepository()
    @ObservedObject var availabilityRepository = AvailabilityRepository()
    var user: User
    var event: Event
    @State var selectedSlots: [Bool]
    let calendar = Calendar.current
    
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
                        Button(action: {
                            availability.times = selectedSlots
                            availability.indicated = true
                            availabilityRepository.update(availability)
                            self.presentationMode.wrappedValue.dismiss()
                            self.selectedAvailabilityNotification()
                        }) {
                            Text("Finish")
                                .frame(maxWidth: 100)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(20)
                        }
                        VStack (alignment: .trailing){
                            HStack {
                                ForEach(0..<7, id: \.self) { day in
                                    VStack {
                                        Text(calendar.date(byAdding: .day, value: day, to: startDate)!.formatted(date: .numeric, time: .omitted))
                                    }
                                }
                            }
                            ForEach(0..<30, id: \.self) { rowIndex in
                                HStack {
                                    Text(calendar.date(byAdding: .minute, value: 30 * rowIndex, to: startDate)!.formatted(date: .omitted, time: .shortened))
                                        .frame(width: 75, alignment: .center)
                                        .padding()
                                    Spacer()
                                    ForEach(0..<7, id: \.self) { columnIndex in
                                        Button(action: {
                                            // Toggle the selected state
                                            selectedSlots[7 * rowIndex + columnIndex].toggle()
                                        }) {
                                            RoundedRectangle(cornerRadius: 5)
                                                .stroke(selectedSlots[7 * rowIndex + columnIndex] ? Color.green : Color.gray, lineWidth: 1)
                                                .frame(width: 25, height: 25)
                                                .background(selectedSlots[7 * rowIndex + columnIndex] ? Color.green.opacity(0.5) : Color.clear)
                                        }
                                    }
                                }
                            }
                        }.padding()
                    }
                }
            }
        }
    }
  
  private func selectedAvailabilityNotification() {
//    print("YESSS")
//    let availabilities = availabilityRepository.getByEvent(event.id!)
//    for availability in availabilities {
//      if availability.indicated == false {
//        print("THIS")
//        return
//      }
//    }
//    print("HERE")
//    var eventHost = userRepository.getByID(event.host!)
//    eventHost?.notifications.append(msg)
//    userRepository.update(eventHost!)
    if user.id! != event.host {
      let msg = "\(user.first_name) selected their availability for event: \(event.name)"
      var eventHost = userRepository.getByID(event.host!)
      eventHost?.notifications.insert(msg, at: 0)
      userRepository.update(eventHost!)
    }
  }
}
