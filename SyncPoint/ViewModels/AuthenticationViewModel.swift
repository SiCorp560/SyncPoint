//
//  AuthenticationViewModel.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/15/23.
//

import SwiftUI
import Firebase
import FirebaseAuth
import GoogleSignIn

class AuthenticationViewModel: ObservableObject {
    enum SignInState {
        case signedIn
        case signedOut
    }

    @ObservedObject var userRepository = UserRepository()
    @Published var state: SignInState = .signedOut
    
    func signIn() async -> Bool {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            fatalError("No client ID found in Firebase configuration")
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            print("There is no root view controller")
            return false
        }
        
        do {
            let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
            let user = userAuthentication.user
            guard let idToken = user.idToken else {
                //throw AuthenticationError.tokenError(message: "ID token missing")
                return false
            }
            let accessToken = user.accessToken
            let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
            let result = try await Auth.auth().signIn(with: credential)
            let firebaseUser = result.user
            print("User \(firebaseUser.uid) signed in with email \(firebaseUser.email ?? "unknown")")
            
            if let getUser = userRepository.getByName(user.profile?.familyName ?? "None", user.profile?.givenName ?? "None") {} else {
                let newUser = User(last_name: user.profile?.familyName ?? "None", first_name: user.profile?.givenName ?? "None", email: user.profile?.email ?? "None", phone: "", tbd_events: [], upcoming_events: [], notifications: [])
                userRepository.create(newUser)
            }
            
            state = .signedIn
            return true
        } catch {
            print(error.localizedDescription)
            //errorMessage = error.localizedDescription
            return false
        }
    }
    
//    func signIn() {
//        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
//            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
//                authenticateUser(for: user, with: error)
//            }
//        } else {
//            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//            //let configuration = GIDConfiguration(clientID: clientID)
//            let config = GIDConfiguration(clientID: clientID)
//            GIDSignIn.sharedInstance.configuration = config
//            
//            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
//            guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
//            
//            GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [unowned self] result, error in
//                    authenticateUser(for: result?.user, with: error)
//            }
//        }
//    }
    
//    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//        
//        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
//        
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
//        
//        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
//            if let error = error {
//                print(error.localizedDescription)
//            } else {
//                self.state = .signedIn
//            }
//        }
//    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            state = .signedOut
        } catch {
            print(error.localizedDescription)
        }
    }
}
