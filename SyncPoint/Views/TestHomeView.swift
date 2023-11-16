//
//  TestHomeView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/16/23.
//

import SwiftUI

struct TestHomeView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Text("Signed in as _")
        Button(
            action: { authViewModel.signOut() },
            label: {
                Text("Sign In with Google")
            })
    }
}
