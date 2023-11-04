//
//  EventViewModel.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/4/23.
//

import Foundation
import Combine

class EventViewModel: ObservableObject, Identifiable {

  private let eventRepository = EventRepository()
  @Published var event: Event
  private var cancellables: Set<AnyCancellable> = []
  var id = ""

  init(event: Event) {
      self.event = event
      $event
          .compactMap { $0.id }
          .assign(to: \.id, on: self)
          .store(in: &cancellables)
  }

  func update(event: Event) {
      eventRepository.update(event)
  }

  func destroy(event: Event) {
      eventRepository.delete(event)
  }
  
}
