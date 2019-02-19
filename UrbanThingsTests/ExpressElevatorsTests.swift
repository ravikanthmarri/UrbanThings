//
//  ExpressElevatorsTests.swift
//  UrbanThingsTests
//
//  Created by R K Marri on 19/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import XCTest
@testable import UrbanThings

class ExpressElevatorsTests: XCTestCase {

    func test_load_no_waiting_persons() {
        
        let sut = MultipleMixedUrbanElevators()
        let waitingPersons = [Int]()
        let waitingDestinations = [Int]()
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200, numberOfNormalLifts: 2, numberOfExpressLifts: 2)
        
        XCTAssertEqual(ticks, 0)
    }

    
    func test_load_one_person_to_2nd_floor() {
        
        let sut = MultipleMixedUrbanElevators()
        let waitingPersons = [55]
        let waitingDestinations = [2]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 6, maxPeople: 2, maxWeight: 200, numberOfNormalLifts: 2, numberOfExpressLifts: 2)
        
        XCTAssertEqual(ticks, 5)
    }
    
    func test_load_2_people_express_normal() {
        
        let sut = MultipleMixedUrbanElevators()
        let waitingPersons = [55,65]
        let waitingDestinations = [4,3]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 6, maxPeople: 2, maxWeight: 200, numberOfNormalLifts: 2, numberOfExpressLifts: 2)
        
        XCTAssertEqual(ticks, 13)
    }

    func test_load_4_people_express_2_normal_2_single_trip() {
        
        let sut = MultipleMixedUrbanElevators()
        let waitingPersons = [55,65,60,55]
        let waitingDestinations = [4,3,6,5]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 6, maxPeople: 2, maxWeight: 200, numberOfNormalLifts: 2, numberOfExpressLifts: 2)
        
        XCTAssertEqual(ticks, 21)
    }

    func test_load_6_people_express_3_normal_3_multiple_lifts() {
        
        let sut = MultipleMixedUrbanElevators()
        let waitingPersons = [60,80,75,55,80,90]
        let waitingDestinations = [4,3,6,5,6,5]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 6, maxPeople: 2, maxWeight: 200, numberOfNormalLifts: 2, numberOfExpressLifts: 2)
        
        XCTAssertEqual(ticks, 39)
    }

    
    

}
