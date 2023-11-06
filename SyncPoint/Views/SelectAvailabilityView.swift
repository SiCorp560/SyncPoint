//
//  SelectAvailabilityView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI

struct SelectAvailabilityView: View {
    // Assuming you have some kind of model to hold the availability data
    // You would need to create a structure to manage the selection state for each slot
  @State private var selectedSlots: [[Bool]] = Array(repeating: Array(repeating: false, count: 5), count: 60)

    let days = ["Nov 16", "Nov 17", "Nov 18", "Nov 19", "Nov 20"]
    let times = ["10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00"]

  var body: some View {
    ScrollView {
      
      VStack {
        Text("Select Availability")
            .fontWeight(.bold)
            .font(.title3)
            .padding()
          
  
      
        
        VStack (alignment: .trailing){
          
            HStack {
              ForEach(days, id: \.self) { day in
                VStack {
                  Text(day)
                    
                }
              }
            }
          
          
          ForEach(0..<times.count, id: \.self) { rowIndex in
            
            HStack {
              Text(times[rowIndex])
                .frame(width: 50, alignment: .center)
                .padding()
              
              Spacer()
              
              ForEach(0..<days.count, id: \.self) { columnIndex in
                
                Button(action: {
                  // Toggle the selected state
                  self.selectedSlots[rowIndex][columnIndex].toggle()
                }) {
                  
                  RoundedRectangle(cornerRadius: 5)
                    .stroke(self.selectedSlots[rowIndex][columnIndex] ? Color.green : Color.gray, lineWidth: 1)
                    .frame(width: 50, height: 50)
                    .background(self.selectedSlots[rowIndex][columnIndex] ? Color.green.opacity(0.5) : Color.clear)
                }
              }
            }
          }
        }.padding()
        
        Button(action: {
          // Action when the Finish button is tapped
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



struct SelectAvailabilityView_Previews: PreviewProvider {
    static var previews: some View {
        SelectAvailabilityView()
    }
}
