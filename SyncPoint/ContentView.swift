//
//  ContentView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import SwiftUI
import GoogleSignIn

struct ContentView: View {
  @ObservedObject var userRepository = UserRepository()
  @EnvironmentObject var authViewModel: AuthenticationViewModel
  private let googleUser = GIDSignIn.sharedInstance.currentUser
  
  var body: some View {
    switch authViewModel.state {
    case .signedIn:
      
      if let user = userRepository.getByName(googleUser?.profile?.familyName ?? "", googleUser?.profile?.givenName ?? "") {
        ScheduledEventsView(user: user)
//        TabView {
//          
//          ScheduledEventsView(user: user)
//            .tabItem {
//              Image(systemName: "calendar.badge.clock")
//              Text("Unscheduled")
//            }
//          
//          
//          UpcomingEventsView(user: user)
//            .tabItem {
//              Image(systemName: "calendar.badge.checkmark")
//              Text("Upcoming")
//            }
//          
//          NotificationsView(user: user)
//            .tabItem {
//              Image(systemName: "bell.fill")
//              Text("Notifications")
//            }
//        }
      }
      
    case .signedOut: SignInView()
    }
  }
}

