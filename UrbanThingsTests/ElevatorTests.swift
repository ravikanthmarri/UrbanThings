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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

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
    
    func test_dispatch_gaurd_1st_floor() {
        
        let sut = UrbanElevator()

        let ticks = sut.startDispatching(persons: [])
        
        XCTAssertEqual(ticks, [])
    }

    func test_dispatch_one_person_2nd_floor() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 2)

        let ticks = sut.startDispatching(persons: [firstPerson])
        
        let expectedTicks = [
            "Moving to floor 2",
            "Unloading at floor 2",
            "Moving to floor 1"
            ]
        
        XCTAssertEqual(ticks, expectedTicks)
    }
    
    func test_dispatch_multiple_persons_2nd_floor() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 2)
        let secondPerson = Person(weight: 60, destination: 2)
        let thirdPerson = Person(weight: 70, destination: 2)

        let ticks = sut.startDispatching(persons: [firstPerson, secondPerson, thirdPerson])
        
        let expectedTicks = [
            "Moving to floor 2",
            "Unloading at floor 2",
            "Moving to floor 1"
        ]
        
        XCTAssertEqual(ticks, expectedTicks)
    }
    
    func test_dispatch_multiple_persons_3rd_floor() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 3)
        let secondPerson = Person(weight: 60, destination: 3)
        let thirdPerson = Person(weight: 70, destination: 3)
        
        let ticks = sut.startDispatching(persons: [firstPerson, secondPerson, thirdPerson])
        
        let expectedTicks = [
            "Moving to floor 2",
            "Moving to floor 3",
            "Unloading at floor 3",
            "Moving to floor 2",
            "Moving to floor 1"
        ]
        
        XCTAssertEqual(ticks, expectedTicks)
    }


    func test_dispatch_multiple_persons_2nd_And_5th_floor() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 2)
        let secondPerson = Person(weight: 60, destination: 2)
        let thirdPerson = Person(weight: 70, destination: 2)

        let fourthPerson = Person(weight: 50, destination: 5)
        let fifthPerson = Person(weight: 60, destination: 5)
        let sixthPerson = Person(weight: 70, destination: 5)
        
        let dispatchArray = [
            firstPerson,
            secondPerson,
            thirdPerson,
            fourthPerson,
            fifthPerson,
            sixthPerson
        ]

        let ticks = sut.startDispatching(persons: dispatchArray)
        
        let expectedTicks = [
            "Moving to floor 2",
            "Unloading at floor 2",
            "Moving to floor 3",
            "Moving to floor 4",
            "Moving to floor 5",
            "Unloading at floor 5",
            "Moving to floor 4",
            "Moving to floor 3",
            "Moving to floor 2",
            "Moving to floor 1"

        ]
        
        XCTAssertEqual(ticks, expectedTicks)
    }
    
    func test_dispatch_multiple_persons_3rd_And_5th_one_person_2nd_And_4th() {
        
        let sut = UrbanElevator()
        let firstPerson = Person(weight: 50, destination: 3)
        let secondPerson = Person(weight: 60, destination: 3)
        let thirdPerson = Person(weight: 70, destination: 2)
        
        let fourthPerson = Person(weight: 50, destination: 4)
        let fifthPerson = Person(weight: 60, destination: 5)
        let sixthPerson = Person(weight: 70, destination: 5)
        
        let dispatchArray = [
            firstPerson,
            secondPerson,
            thirdPerson,
            fourthPerson,
            fifthPerson,
            sixthPerson
        ]
        
        let ticks = sut.startDispatching(persons: dispatchArray)
        
        let expectedTicks = [
            "Moving to floor 2",
            "Unloading at floor 2",
            "Moving to floor 3",
            "Unloading at floor 3",
            "Moving to floor 4",
            "Unloading at floor 4",
            "Moving to floor 5",
            "Unloading at floor 5",
            "Moving to floor 4",
            "Moving to floor 3",
            "Moving to floor 2",
            "Moving to floor 1"
            ]
        XCTAssertEqual(ticks, expectedTicks)
    }

}
