//
//  EventRepository.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/1/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class EventRepository: ObservableObject {
    private let path: String = "events"
    private let store = Firestore.firestore()
    
    @Published var events: [Event] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.get()
    }
    
    func get() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting events: \(error.localizedDescription)")
                    return
                }
                
                self.events = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Event.self)
                } ?? []
            }
    }
    
    // MARK: CRUD methods
    func create(_ event: Event) {
        do {
            let newEvent = event
            _ = try store.collection(path).addDocument(from: newEvent)
          //return newEvent.documentID
        } catch {
            fatalError("Unable to add event: \(error.localizedDescription).")
        }
      
    }

    func update(_ event: Event) {
        guard let eventId = event.id else { return }
        
        do {
            try store.collection(path).document(eventId).setData(from: event)
        } catch {
            fatalError("Unable to update event: \(error.localizedDescription).")
        }
    }

    func delete(_ event: Event) {
        guard let eventId = event.id else { return }
        
        store.collection(path).document(eventId).delete { error in
            if let error = error {
                print("Unable to remove event: \(error.localizedDescription)")
            }
        }
    }
  
  func getByID(_ id: String) -> Event? {
          return self.events.filter{$0.id == id}.first
      }
}
