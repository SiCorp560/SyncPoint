//
//  ViewTests.swift
//  SyncPointTests
//
//  Created by Simon Corpuz on 12/8/23.
//

import XCTest
@testable import SyncPoint
import SwiftUI

final class ViewTests: XCTestCase {
    var user1: User!
    var event1: Event!
    var availability1: Availability!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        user1 = User(id: "user1", last_name: "One", first_name: "User", email: "p1@gmail.com", phone: "(412) 123-4567", tbd_events: ["event1"], upcoming_events: [], notifications: [])
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = 12
        dateComponents.day = 24
        let date = Calendar.current.date(from: dateComponents)!
        
        event1 = Event(id: "event1", name: "Event One", description: "This is a test event from ModelTests.swift", participants: ["user1", "user2"], earliest_date: date, host: "user1")
        
        let blankTimes = Array(repeating: false, count: 7*30)
        availability1 = Availability(id: "avail1", user: "user1", event: "event1", times: blankTimes, indicated: true)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
    
    func testNewEventView() throws {
        var view = NewEventView(user: user1)
        view.clearFields()
        XCTAssertEqual(view.getName(), "")
        XCTAssertEqual(view.getDescription(), "")

        let earliestDate = view.getEarliestDate()
        XCTAssertEqual(Calendar.current.component(.day, from: earliestDate),Calendar.current.component(.day, from: Date()))
        XCTAssertEqual(Calendar.current.component(.hour, from: earliestDate),Calendar.current.component(.hour, from: Date()))
        
        XCTAssertEqual(view.getParticipants(), [])
        XCTAssert(!view.getEventCreatedStatus())
        XCTAssert(!view.isValidEvent())
    }
    
    func testEventDetailsView() throws {
        var view = EventDetailsView(user: user1, event: event1)
        XCTAssert(!view.readyToPick())
    }
    
    func testEditEventView() throws {
        var view = EditEventView(user: user1, event: event1)
        XCTAssert(!view.isValidEdit())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
