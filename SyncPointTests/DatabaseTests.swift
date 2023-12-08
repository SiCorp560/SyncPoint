//
//  DatabaseTests.swift
//  SyncPointTests
//
//  Created by Simon Corpuz on 12/8/23.
//

import XCTest
@testable import SyncPoint
import SwiftUI

final class DatabaseTests: XCTestCase {
    var user1: User!
    var user2: User!
    var userViewModel: UserViewModel!
    var userRepository: UserRepository!
    var event1: Event!
    var event2: Event!
    var eventViewModel: EventViewModel!
    var eventRepository: EventRepository!
    var availability1: Availability!
    var availability2: Availability!
    var availability3: Availability!
    var availability4: Availability!
    var availabilityViewModel: AvailabilityViewModel!
    var availabilityRepository: AvailabilityRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        user1 = User(id: "user1", last_name: "One", first_name: "User", email: "p1@gmail.com", phone: "(412) 123-4567", tbd_events: ["event1", "event2"], upcoming_events: [], notifications: [])
        user2 = User(id: "user2", last_name: "Two", first_name: "User", email: "p2@gmail.com", phone: "(412) 345-6789", tbd_events: ["event1", "event2"], upcoming_events: [], notifications: [])
        userViewModel = UserViewModel(user: user1)
        userRepository = UserRepository()
        userRepository.users = [user1, user2]
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 12
        dateComponents.day = 24
        let date = Calendar.current.date(from: dateComponents)!
        
        event1 = Event(id: "event1", name: "Event One", description: "This is a test event from DatabaseTests.swift", participants: ["user1", "user2"], earliest_date: date, host: "user1")
        event2 = Event(id: "event2", name: "Event Two", description: "This is another test event from DatabaseTests.swift", participants: ["user1", "user2"], earliest_date: date, host: "user2")
        eventViewModel = EventViewModel()
        eventRepository = EventRepository()
        eventRepository.events = [event1, event2]
        
        let blankTimes = Array(repeating: false, count: 7*30)
        availability1 = Availability(id: "avail1", user: "user1", event: "event1", times: blankTimes, indicated: true)
        availability2 = Availability(id: "avail2", user: "user2", event: "event1", times: blankTimes, indicated: true)
        availability3 = Availability(id: "avail3", user: "user1", event: "event2", times: blankTimes, indicated: true)
        availability4 = Availability(id: "avail4", user: "user2", event: "event2", times: blankTimes, indicated: false)
        availabilityViewModel = AvailabilityViewModel(availability: availability1)
        availabilityRepository = AvailabilityRepository()
        availabilityRepository.availabilities = [availability1, availability2, availability3, availability4]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        user1 = nil
        user2 = nil
        userViewModel = nil
        userRepository = nil
        
        event1 = nil
        event2 = nil
        eventViewModel = nil
        eventRepository = nil
        
        availability1 = nil
        availability2 = nil
        availability3 = nil
        availability4 = nil
        availabilityViewModel = nil
        availabilityRepository = nil
        super.tearDown()
    }

    func testUserMethods() throws {
        // MARK: UserRepository methods
        var getUser = userRepository.getByID("user1")
        XCTAssertNotNil(getUser)
        getUser = userRepository.getByID("user2")
        XCTAssertNotNil(getUser)
        
        getUser = userRepository.getByName("One", "User")
        XCTAssertNotNil(getUser)
        getUser = userRepository.getByName("Two", "User")
        XCTAssertNotNil(getUser)
    }
    
    func testEventMethods() throws {
        // MARK: EventRepository methods
        var getEvent = eventRepository.getByID("event1")
        XCTAssertNotNil(getEvent)
    }
    
    func testAvailabilityMethods() throws {
        // MARK: AvailabilityRepository methods
        var getAvails = availabilityRepository.getByEvent("event1")
        XCTAssertEqual(getAvails.count, 2)
        
        var getAvail = availabilityRepository.getByBoth("user1", "event2")
        XCTAssertNotNil(getAvail)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
