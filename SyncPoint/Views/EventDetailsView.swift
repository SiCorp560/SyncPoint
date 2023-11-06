//
//  EventDetailsView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//
import SwiftUI


struct EventDetailsView: View {
    @ObservedObject var userRepository = UserRepository()
  
    var event: Event
    
    let calendar = Calendar.current
  
    
  var body: some View {
    NavigationView {
      VStack {
      
          // Event name
        Text(event.name)
          .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
          .font(.title2)
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.3))
          .cornerRadius(8)
        
        // Date and time
        
        Text("Date and Time:")
          .font(.headline)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
        
      
        if let startDate = event.final_meeting_start, let endDate = event.final_meeting_end {
          let newEndDate = calendar.date(byAdding: .minute, value: 1, to: endDate)!
          
          VStack(alignment: .leading){
            HStack{
              Image(systemName: "calendar")
              Text(startDate.formatted(date: .abbreviated, time: .omitted))
            }
            
            
            HStack{
              Image(systemName: "clock")
              Text("\(startDate.formatted(date: .omitted, time: .shortened)) - \(newEndDate.formatted(date: .omitted, time: .shortened))")
            }
          }
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.3))
          .cornerRadius(8)
          
          
        
        } else {
            
          HStack{
                Image(systemName: "calendar")
                Text("TBD")
            }
            
          HStack{
                Image(systemName: "clock")
                Text("TBD")
            }
        }
        
        
        // Event description
        Text("Description:")
          .font(.headline)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
        
        Text(event.description)
          .frame(maxWidth: 340, alignment: .leading)
          .padding()
          .background(Color.green.opacity(0.3))
          .cornerRadius(8)
        
      
        
        // Participants
        Text("Participants:")
          .font(.headline)
          .foregroundColor(.black)
          .frame(maxWidth: .infinity, alignment: .leading)
          .padding()
        
          HStack{
            ForEach(event.participants, id: \.self) { name in
              Text(name ?? "user")
                .frame(width: 55, height: 35, alignment: .center)
                .padding()
                .background(
                      Circle()
                        .fill(Color.green.opacity(0.3))
                ).foregroundColor(.black)
            }
          }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        
        
        // Buttons and other features
        HStack{
          Button(action: {}) {
            Text("Select Availability")
              .foregroundColor(.white)
          }
          .padding()
          .background(Color.green)
          .cornerRadius(25)
          
          Button(action: {}) {
            Text("View All Times")
              .foregroundColor(.white)
          }
          .padding()
          .background(Color.green)
          .cornerRadius(25)
        }
        .padding()
        
        Spacer()
        
      }.navigationBarTitle(Text("Event Details"), displayMode: .inline)
    }
  }
  }


//extension Event {
//    static var mock: Event {
//        return Event(
//          id: "1",
//          name: "Mentor Meeting",
//          description: "Get feedback on sprint 3, ask app design suggestions and talk about database.",
//          participants: ["Ammar", "Simon", "Ahmad", "Matt"],
//          earliest_date: Date(),
//          final_meeting_start: Date(),
//          final_meeting_end: Date().addingTimeInterval(3600),
//          host: "Ammar"
//        )
//    }
//}
//#Preview {
//  EventDetailsView(event: .mock)
//}
