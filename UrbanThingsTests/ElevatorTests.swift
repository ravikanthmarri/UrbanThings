//
//  ElevatorTests.swift
//  UrbanThingsTests
//
//  Created by R K Marri on 18/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import XCTest
@testable import UrbanThings

class ElevatorTests: XCTestCase {
    
    func test_load_zero_persons_no_waiting_persons() {
        
        let sut = UrbanElevator()
        let waitingPersons = [Int]()
        let waitingDestinations = [Int]()
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 0)
    }

    func test_load_one_person_to_2nd_floor() {
        
        let sut = UrbanElevator()
        let waitingPersons = [55]
        let waitingDestinations = [2]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 5)
    }

    
    func test_sample_input() {
        
        let sut = UrbanElevator()
        let waitingPersons = [60, 80, 40]
        let waitingDestinations = [2, 3, 2]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 12)
        
    }

}
