//
//  AvailabilityRepository.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 11/1/23.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

class AvailabilityRepository: ObservableObject {
    private let path: String = "availabilities"
    private let store = Firestore.firestore()
    
    @Published var availabilities: [Availability] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        self.get()
    }
    
    func get() {
        store.collection(path)
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error getting availabilities: \(error.localizedDescription)")
                    return
                }
                
                self.availabilities = querySnapshot?.documents.compactMap { document in
                    try? document.data(as: Availability.self)
                } ?? []
            }
    }
    
    // MARK: CRUD methods
    func create(_ availability: Availability) {
        do {
            let newAvailability = availability
            _ = try store.collection(path).addDocument(from: newAvailability)
        } catch {
            fatalError("Unable to add availability: \(error.localizedDescription).")
        }
    }

    func update(_ availability: Availability) {
        guard let availabilityId = availability.id else { return }
        
        do {
            try store.collection(path).document(availabilityId).setData(from: availability)
        } catch {
            fatalError("Unable to update availability: \(error.localizedDescription).")
        }
    }

    func delete(_ availability: Availability) {
        guard let availabilityId = availability.id else { return }
        
        store.collection(path).document(availabilityId).delete { error in
            if let error = error {
                print("Unable to remove availability: \(error.localizedDescription)")
            }
        }
    }
}
