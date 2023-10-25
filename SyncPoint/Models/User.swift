//
//  User.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Identifiable, Comparable, Codable {
    
    // MARK: Fields
    @DocumentID var id: String?
    var last_name: String
    var first_name: String
    var email: String
    var phone: String
    //var picture: Image?
    var tbd_events: [Event]?
    var upcoming_events: [Event]?

  
    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case last_name
        case first_name
        case email
        case phone
        //case picture
        case tbd_events
        case upcoming_events
    }
  
    // MARK: Comparable
    static func ==(first: User, second: User) -> Bool {
        return first.last_name == second.last_name && first.first_name == second.first_name
    }
  
    static func <(first: User, second: User) -> Bool {
        return first.last_name < second.last_name
    }
  
}
