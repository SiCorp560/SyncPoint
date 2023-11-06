//
//  UserViewModel.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/3/23.
//

import Foundation
import Combine

class UserViewModel: ObservableObject, Identifiable {

//  // variable for search functionality
//  @Published var searchQuery = ""
//  @Published var searchResults: [User] = []
//  private var searchCancellable: AnyCancellable?
  
  @Published var users: [User] = []
  @Published var searchText: String = ""
  @Published var filteredUsers: [User] = []

  
  private let userRepository = UserRepository()
  @Published var user: User
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(user: User) {
      self.user = user
      $user
          .compactMap { $0.id }
          .assign(to: \.id, on: self)
          .store(in: &cancellables)
    
  }
  
  func search(searchText: String) {
        self.filteredUsers = self.users.filter { user in
          return self.user.first_name.lowercased().contains(searchText.lowercased())
        }
      }
  
  func update(user: User) {
      userRepository.update(user)
  }

  func destroy(user: User) {
      userRepository.delete(user)
  }
  
}
