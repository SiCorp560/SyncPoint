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
            }
            case .signedOut: SignInView()
        }
    }
}

#Preview {
    ContentView()
}
