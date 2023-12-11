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
        VStack {
            Spacer()
            
            Text("SYNCPOINT")
                .font(.custom("Copperplate", size: 58))
                .fontWeight(.heavy)
                .foregroundColor(.black)

            Button(action: { Task {await authViewModel.signIn()} }) {
                
              HStack {
                GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .icon, state: .normal)){}
                  .cornerRadius(10)
                    
                //Image(systemName: "person.badge.key.fill")
                        //.foregroundColor(.white)
                    Text("Sign in with Google")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                
                
                }.frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .cornerRadius(100)
                .padding(.horizontal)
              
            }.frame(maxWidth: 300)
          
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.lightGreen.edgesIgnoringSafeArea(.all))
    }
}

extension Color {
    static let lightGreen = Color(red: 0.80, green: 0.95, blue: 0.8)
}

#Preview {
  SignInView()
}
