//
//  TestView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 06/11/2023.
//

import SwiftUI

struct TestView: View {
  
  @ObservedObject var userRepository = UserRepository()
  
    
  var body: some View {
    @State var displayedUsers = userRepository.users
    
    List{ForEach(displayedUsers) { user in
      Text(user.first_name)
    }
    }
  }
}

#Preview {
    TestView()
}
