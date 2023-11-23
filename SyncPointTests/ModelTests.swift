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
    var user3: User!
    var userViewModel: UserViewModel!
    var userRepository: UserRepository!
    var event: Event!
    var eventRepository: EventRepository!
    var availability: Availability!
    var availabilityViewModel: AvailabilityViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        user1 = User(id: "test1", last_name: "Man", first_name: "Test", email: "tman@gmail.com", phone: "(412) 123-4567", tbd_events: ["event1"], upcoming_events: [], notifications: [])
        user2 = User(id: "test2", last_name: "Guy", first_name: "Testing", email: "tguy@gmail.com", phone: "(412) 345-6789", tbd_events: ["event1"], upcoming_events: [], notifications: [])
        user3 = User(id: "test3", last_name: "Person", first_name: "Other", email: "operson@gmail.com", phone: "(412) 901-2345", tbd_events: [], upcoming_events: [], notifications: [])
        userViewModel = UserViewModel(user: user1)
        userRepository = UserRepository()
        userRepository.users = [user1, user2, user3]
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 11
        dateComponents.day = 10
        let date = Calendar.current.date(from: dateComponents)!
        
        event = Event(id: "event1", name: "Test Event", description: "This is a test event from ModelTests.swift", participants: ["test1", "test2"], earliest_date: date, host: "test1")
        eventRepository = EventRepository()
        eventRepository.events = [event]
        
        //availability = Availability(id: "avail1", user: "test1", event: "event1", times: [date], indicated: true)
        //availabilityViewModel = AvailabilityViewModel(availability: availability)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        user1 = nil
        user2 = nil
        user3 = nil
        userViewModel = nil
        userRepository = nil
        
        event = nil
        eventRepository = nil
        
        //availability = nil
        //availabilityViewModel = nil
        super.tearDown()
    }

    func testUserMethods() throws {
        // MARK: Basic User fields
        XCTAssertNotNil(userViewModel.user)
        XCTAssertEqual(userViewModel.user.last_name, "Man")
        XCTAssertEqual(userViewModel.user.first_name, "Test")
        XCTAssertEqual(userViewModel.user.email, "tman@gmail.com")
        XCTAssertEqual(userViewModel.user.phone, "(412) 123-4567")
        XCTAssertEqual(userViewModel.user.tbd_events.count, 1)
        XCTAssertEqual(userViewModel.user.upcoming_events.count, 0)
        XCTAssertEqual(userViewModel.user.notifications.count, 0)
        
        // MARK: UserRepository get methods
        var getUser = userRepository.getByID("test1")
        XCTAssertNotNil(getUser)
        
        getUser = userRepository.getByName("Man", "Test")
        XCTAssertNotNil(getUser)
    }
    
    func testEventMethods() throws {
        // MARK: Basic Event fields
        XCTAssertNotNil(event)
        XCTAssertEqual(event.name, "Test Event")
        XCTAssertEqual(event.description, "This is a test event from ModelTests.swift")
        XCTAssertEqual(event.host, "test1")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 11
        dateComponents.day = 10
        let date = Calendar.current.date(from: dateComponents)!
        XCTAssertEqual(event.earliest_date, date)
        
        XCTAssertEqual(event.participants.count, 2)
        
        // MARK: EventRepository get methods
        let getEvent = eventRepository.getByID("event1")
        XCTAssertNotNil(getEvent)
    }
    
//    func testAvailabilityMethods() throws {
//        // MARK: Basic Availability fields
//        XCTAssertNotNil(availabilityViewModel.availability)
//        XCTAssertEqual(availabilityViewModel.availability.user, "test1")
//        XCTAssertEqual(availabilityViewModel.availability.event, "event1")
//        XCTAssertEqual(availabilityViewModel.availability.times.count, 1)
//        XCTAssert(availabilityViewModel.availability.indicated)
//    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
