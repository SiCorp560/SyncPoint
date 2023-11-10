//
//  AvailabilityViewModel.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/4/23.
//

import Foundation
import Combine

class AvailabilityViewModel: ObservableObject, Identifiable {

  private let availabilityRepository = AvailabilityRepository()
  @Published var availability: Availability
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(availability: Availability) {
      self.availability = availability
      $availability
          .compactMap { $0.id }
          .assign(to: \.id, on: self)
          .store(in: &cancellables)
  }

  func update(availability: Availability) {
      availabilityRepository.update(availability)
  }

  func destroy(availability: Availability) {
      availabilityRepository.delete(availability)
  }
  
}
