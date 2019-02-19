//
//  MultipleElevatorsTests.swift
//  UrbanThingsTests
//
//  Created by R K Marri on 19/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import XCTest
@testable import UrbanThings


class MultipleElevatorsTests: XCTestCase {

    func test_load_no_waiting_persons() {
        
        let sut = MultipleUrbanElevators()
        let waitingPersons = [Int]()
        let waitingDestinations = [Int]()
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200, numberOfLifts: 3)
        
        XCTAssertEqual(ticks, 0)
    }
    
    func test_load_one_person_to_2nd_floor() {
        
        let sut = MultipleUrbanElevators()
        let waitingPersons = [55]
        let waitingDestinations = [2]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200, numberOfLifts: 3)
        
        XCTAssertEqual(ticks, 5)
    }

    func test_load_two_persons_to_2nd_4th_floor() {
        
        let sut = MultipleUrbanElevators()
        let waitingPersons = [55,67]
        let waitingDestinations = [2,4]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200, numberOfLifts: 3)
        
        XCTAssertEqual(ticks, 10)
    }
    
    func test_load_4_persons_to_use_2_lifts() {
        
        let sut = MultipleUrbanElevators()
        let waitingPersons = [55,67,50,45]
        let waitingDestinations = [2,4,3,5]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 150, numberOfLifts: 3)
        
        XCTAssertEqual(ticks, 21)
    }

    
    func test_load_6_persons_to_use_3_lifts_max_3_peoplePerLift() {
        
        let sut = MultipleUrbanElevators()
        let waitingPersons = [55,67,50,45,40,80]
        let waitingDestinations = [2,4,3,5,4,5]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 3, maxWeight: 150, numberOfLifts: 4)
        
        XCTAssertEqual(ticks, 32)
    }
}
