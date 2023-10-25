//
//  TestUserView.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import SwiftUI

struct TestUserView: View {
    @ObservedObject var userRepository = UserRepository()
    
    var body: some View {
        let users = userRepository.users.sorted()
        
        Text("THIS HAS BEEN BUILT SUCCESSFULLY, NOT FROZEN")
        
        List {
            ForEach(users) { user in
                Text("\(user.last_name)")
            }
        }
    }
}
