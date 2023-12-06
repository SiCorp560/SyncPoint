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
        
            let startDate = event.earliest_date
            
            if var availability = availabilityRepository.getByBoth(user.id!, event.id!) {
                
              ScrollView {
                    VStack {
                      
                      HStack{
                        Text("Select Availability")
                          .fontWeight(.bold)
                          .font(.title3)
                          .padding()
                        
                        
                        
                        Button(action: {
                          
                          availability.times = selectedSlots
                          availability.indicated = true
                          availabilityRepository.update(availability)
                          self.presentationMode.wrappedValue.dismiss()
                          
                        }) {
                          Text("Finish")
                            .font(.system(size: 15))
                            .frame(maxWidth: 35,  maxHeight: 10)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(50)
                        }
                      }
                      
                      
                      
                        VStack (alignment: .trailing) {
                          
                          HStack {
                            
                            ForEach(0..<7, id: \.self) { dayOffset in
                              let date = calendar.date(byAdding: .day, value: dayOffset, to: startDate)!
                              Text(date.formatted(Date.FormatStyle().day().month()))
                                .frame(width: 34, alignment: .center)
                                .font(.system(size: 14))
                            }
                          }

                                      
                          
                        ForEach(0..<17, id: \.self) { rowIndex in
                          
                          HStack {
                            
                            Text(calendar.date(byAdding: .minute, value: 30 * rowIndex, to: startDate)!
                              .formatted(date: .omitted, time:.shortened))
                            .font(.system(size: 14))
                            .frame(width: 70, alignment: .leading)
                            
                            
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
                      }.padding()
                    }
                }
            }
    }
}
