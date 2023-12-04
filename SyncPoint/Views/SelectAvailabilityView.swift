//
//  SelectAvailabilityView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI

struct SelectAvailabilityView: View {
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
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
          
          VStack (alignment: .trailing) {
            
            HStack {
              
              ForEach(0..<7, id: \.self) { day in
                
                Text(calendar.date(byAdding: .day, value: day, to: startDate)!
                  .formatted(Date.FormatStyle().day().month()))
                .font(.system(size: 12))
                
              }
            }
            
            // Rows for times
            
            ForEach(0..<30, id: \.self) { rowIndex in
              
              HStack {
                
                Text(calendar.date(byAdding: .minute, value: 30 * rowIndex, to: startDate)!
                  .formatted(date: .omitted, time:.shortened))
                .frame(width: 75, alignment: .leading)
                
                Spacer()
                
                ForEach(0..<7, id: \.self) { columnIndex in
                  
                  Button(action: {
                    // Toggle the selected state
                    selectedSlots[7 * rowIndex + columnIndex].toggle()
                  }) {
                    
                    
                    RoundedRectangle(cornerRadius: 5)
                      .stroke(selectedSlots[7 * rowIndex + columnIndex] ? Color.green : Color.gray, lineWidth: 1)
                      .frame(width: 34, height: 34)
                      .background(selectedSlots[7 * rowIndex + columnIndex] ? Color.green.opacity(0.5) : Color.clear)
                  }
                }
              }
            }
            
            
            Button(action: {
              availability.times = selectedSlots
              availability.indicated = true
              availabilityRepository.update(availability)
              self.presentationMode.wrappedValue.dismiss()
            }) {
              Text("Finish")
                .frame(maxWidth: 100)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(20)
            }
          }.padding()
        }.padding()
      }
    }.navigationBarTitle(Text("Select Availability"), displayMode: .inline)
  }
}





