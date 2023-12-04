//
//  SignInView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/15/23.
//

import SwiftUI
import GoogleSignInSwift

struct SignInView: View {
    @EnvironmentObject var authViewModel: AuthenticationViewModel
    
    var body: some View {
        Button(
            action: { Task {await authViewModel.signIn()} },
            label: {
                Text("Sign In with Google")
            })
    }
}



