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

    func test_sample_input_ordinary_lift_1_trip() {
        
        let sut = UrbanElevator()
        let waitingPersons = [60, 80]
        let waitingDestinations = [2, 3]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 8)
    }

    
    func test_sample_input_ordinary_lift_2_trips() {
        
        let sut = UrbanElevator()
        let waitingPersons = [60, 80, 40]
        let waitingDestinations = [2, 3, 2]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 5, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 12)
    }

    func test_sample_input1_express_lift_1_trip() {
        
        let sut = UrbanElevator(isExpress: true)
        let waitingPersons = [60, 80]
        let waitingDestinations = [4, 6]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 6, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 10)
    }

    func test_sample_input2_express_lift_2_trips() {
        
        let sut = UrbanElevator(isExpress: true)
        let waitingPersons = [60, 80, 90]
        let waitingDestinations = [4, 6, 4]
        
        let ticks = sut.calculateLiftTicks(for: waitingPersons, destinations: waitingDestinations, numberOfFloors: 6, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(ticks, 16)
    }

    
    

}
