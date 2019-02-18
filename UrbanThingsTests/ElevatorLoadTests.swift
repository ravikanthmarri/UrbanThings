//
//  ElevatorLoadTests.swift
//  UrbanThingsTests
//
//  Created by R K Marri on 18/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import XCTest
@testable import UrbanThings

class ElevatorLoadTests: XCTestCase {
    
    func test_load_zero_persons_no_waiting_persons() {
        
        let sut = UrbanElevator()
        var waitingPersons = [Person]()
        
        let loadedArray = sut.load(waitingArray: &waitingPersons, maxPeople: 2, maxWeight: 200)
        
        XCTAssertEqual(loadedArray.count, 0)
    }
    
    
    func test_load_zero_persons_waitLimit() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 150, destination: 4)
        var waitingPersons = [firstPerson]
        
        let loadedArray = sut.load(waitingArray: &waitingPersons, maxPeople: 2, maxWeight: 100)
        
        XCTAssertEqual(loadedArray, [])
    }
    
    
    
    func test_load_one_person_weightLimit() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 4)
        let secondPerson = Person(weight: 100, destination: 2)
        var waitingPersons = [
            firstPerson,
            secondPerson
        ]
        
        let loadedArray = sut.load(waitingArray: &waitingPersons, maxPeople: 2, maxWeight: 100)
        
        XCTAssertEqual(loadedArray, [firstPerson])
    }
    
    func test_load_two_persons_weightLimit() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 4)
        let secondPerson = Person(weight: 100, destination: 2)
        let thirdPerson = Person(weight: 70, destination: 3)
        
        var waitingPersons = [
            firstPerson,
            secondPerson,
            thirdPerson
        ]
        
        let loadedArray = sut.load(waitingArray: &waitingPersons, maxPeople: 2, maxWeight: 150)
        
        XCTAssertEqual(loadedArray, [firstPerson,secondPerson])
    }
    
    func test_load_two_persons_maxPeopleLimit() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 4)
        let secondPerson = Person(weight: 55, destination: 2)
        let thirdPerson = Person(weight: 70, destination: 3)
        
        var waitingPersons = [
            firstPerson,
            secondPerson,
            thirdPerson
        ]
        
        
        let loadedArray = sut.load(waitingArray: &waitingPersons, maxPeople: 2, maxWeight: 250)
        
        XCTAssertEqual(loadedArray, [firstPerson,secondPerson])
    }
    
    func test_load_three_persons_maxPeopleLimit() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 4)
        let secondPerson = Person(weight: 55, destination: 2)
        let thirdPerson = Person(weight: 70, destination: 3)
        let fourthPerson = Person(weight: 70, destination: 3)
        
        
        var waitingPersons = [
            firstPerson,
            secondPerson,
            thirdPerson,
            fourthPerson
        ]
        
        
        let loadedArray = sut.load(waitingArray: &waitingPersons, maxPeople: 3, maxWeight: 250)
        
        XCTAssertEqual([firstPerson,secondPerson,thirdPerson], loadedArray)
    }

}
