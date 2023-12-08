//
//  ModelTests.swift
//  SyncPointTests
//
//  Created by Simon Corpuz on 11/8/23.
//

import XCTest
@testable import SyncPoint
import SwiftUI

final class ModelTests: XCTestCase {
    var user1: User!
    var user2: User!
    var userViewModel: UserViewModel!
    var event1: Event!
    var event2: Event!
    var eventViewModel: EventViewModel!
    var availability1: Availability!
    var availability2: Availability!
    var availability3: Availability!
    var availability4: Availability!
    var availabilityViewModel: AvailabilityViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        user1 = User(id: "user1", last_name: "One", first_name: "User", email: "p1@gmail.com", phone: "(412) 123-4567", tbd_events: ["event1"], upcoming_events: [], notifications: [])
        user2 = User(id: "user2", last_name: "Two", first_name: "User", email: "p2@gmail.com", phone: "(412) 345-6789", tbd_events: ["event1"], upcoming_events: [], notifications: [])
        userViewModel = UserViewModel(user: user1)
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 12
        dateComponents.day = 24
        let date = Calendar.current.date(from: dateComponents)!
        
        event1 = Event(id: "event1", name: "Event One", description: "This is a test event from ModelTests.swift", participants: ["user1", "user2"], earliest_date: date, host: "user1")
        event2 = Event(id: "event2", name: "Event Two", description: "This is another test event from DatabaseTests.swift", participants: ["user1", "user2"], earliest_date: date, host: "user2")
        
        let blankTimes = Array(repeating: false, count: 7*30)
        availability1 = Availability(id: "avail1", user: "user1", event: "event1", times: blankTimes, indicated: true)
        availability2 = Availability(id: "avail2", user: "user2", event: "event1", times: blankTimes, indicated: true)
        availability3 = Availability(id: "avail3", user: "user1", event: "event2", times: blankTimes, indicated: true)
        availability4 = Availability(id: "avail4", user: "user2", event: "event2", times: blankTimes, indicated: false)
        availabilityViewModel = AvailabilityViewModel(availability: availability1)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        user1 = nil
        user2 = nil
        userViewModel = nil
        
        event1 = nil
        event2 = nil
        
        availability1 = nil
        availability2 = nil
        availability3 = nil
        availability4 = nil
        availabilityViewModel = nil
        super.tearDown()
    }

    func testUserMethods() throws {
        // MARK: Basic User fields
        XCTAssertNotNil(userViewModel.user)
        XCTAssertEqual(userViewModel.user.last_name, "One")
        XCTAssertEqual(userViewModel.user.first_name, "User")
        XCTAssertEqual(userViewModel.user.email, "p1@gmail.com")
        XCTAssertEqual(userViewModel.user.phone, "(412) 123-4567")
        XCTAssertEqual(userViewModel.user.tbd_events.count, 1)
        XCTAssertEqual(userViewModel.user.upcoming_events.count, 0)
        XCTAssertEqual(userViewModel.user.notifications.count, 0)
        
        // MARK: User comparable
        XCTAssertNotEqual(user1, user2)
        XCTAssert(user1 < user2)
    }
    
    func testEventMethods() throws {
        // MARK: Basic Event fields
        XCTAssertNotNil(event1)
        XCTAssertEqual(event1.name, "Event One")
        XCTAssertEqual(event1.description, "This is a test event from ModelTests.swift")
        XCTAssertEqual(event1.host, "user1")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 12
        dateComponents.day = 24
        let date = Calendar.current.date(from: dateComponents)!
        XCTAssertEqual(event1.earliest_date, date)
        
        XCTAssertEqual(event1.participants.count, 2)
        
        // MARK: Event comparable
        XCTAssertNotEqual(event1, event2)
        XCTAssert(event1 < event2)
        XCTAssertEqual(event1.getID(), "event1")
    }
    
    func testAvailabilityMethods() throws {
        // MARK: Basic Availability fields
        XCTAssertNotNil(availabilityViewModel.availability)
        XCTAssertEqual(availabilityViewModel.availability.user, "user1")
        XCTAssertEqual(availabilityViewModel.availability.event, "event1")
        XCTAssertEqual(availabilityViewModel.availability.times.count, 7*30)
        XCTAssert(availabilityViewModel.availability.indicated)
        
        // MARK: Availability comparable
        XCTAssertNotEqual(availability1, availability2)
        XCTAssert(availability1 < availability3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
