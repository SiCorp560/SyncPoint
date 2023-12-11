//
//  NotificationsView.swift
//  SyncPoint
//
//  Created by Ammar Raza on 03/11/2023.
//

import SwiftUI



struct NotificationsView: View {
  
  var user: User
  var body: some View {
    List(user.notifications, id: \.self) { notification in
      Text(notification)
    }
  }
}
