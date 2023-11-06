//
//  Event.swift
//  SyncPoint
//
//  Created by Simon Corpuz on 10/24/23.
//

import Foundation
import FirebaseFirestoreSwift

struct Event: Identifiable, Comparable, Codable {
    
    // MARK: Fields
    @DocumentID var id: String?
    var name: String
    var description: String
    var participants: [String?]
    var earliest_date: Date
    var final_meeting_start: Date?
    var final_meeting_end: Date?
    var host: String?


    // MARK: Codable
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case participants
        case earliest_date
        case final_meeting_start
        case final_meeting_end
        case host
    }
  
    // MARK: Comparable
    static func ==(first: Event, second: Event) -> Bool {
        return first.name == second.name && first.description == second.description
    }
  
    static func <(first: Event, second: Event) -> Bool {
        return first.name < second.name
    }
  
}
