//
//  Availability.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Availability: Identifiable, Comparable, Codable {
    
    // MARK: Fields
    @DocumentID var id: String?
    var user: User
    var event: Event
    var times: [Date]?
    var indicated: Bool


    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case user
        case event
        case times
        case indicated
    }
  
    // MARK: Comparable
    static func ==(first: Availability, second: Availability) -> Bool {
        return first.user == second.user && first.event == second.event
    }
  
    static func <(first: Availability, second: Availability) -> Bool {
        return first.event < second.event
    }
  
}

