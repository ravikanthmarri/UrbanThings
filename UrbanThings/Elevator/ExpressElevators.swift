//
//  ExpressElevators.swift
//  UrbanThings
//
//  Created by R K Marri on 19/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

protocol ExpressElevators {
    
    func calculateLiftTicks(for people:[Int], destinations:[Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int, numberOfNormalLifts: Int, numberOfExpressLifts: Int) -> Int
 
}

class MultipleMixedUrbanElevators: ExpressElevators {
    
    func calculateLiftTicks(for people: [Int], destinations: [Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int, numberOfNormalLifts: Int, numberOfExpressLifts: Int) -> Int {
        
        // Input validation
        if people.isEmpty || destinations.isEmpty || people.count != destinations.count {
            return 0
        }
        
        print("\n\nTick     Lift Status\n")
        
        var ticks = [String]()
        let normalElevtors = createLifts(numberOfLifts: numberOfNormalLifts, isExpress: false)
        let expressElevtors = createLifts(numberOfLifts: numberOfExpressLifts, isExpress: true)
        
        var normalWaitingPeopleArray = [Person]()
        var expressWaitingPeopleArray = [Person]()
        
        // Devide people based on destinations
        for (index, weight) in people.enumerated() {
            if destinations[index] % 2 == 0 {
                expressWaitingPeopleArray.append(Person(weight: weight, destination: destinations[index]))
            }else {
                normalWaitingPeopleArray.append(Person(weight: weight, destination: destinations[index]))
            }
        }
        
        let normalTicks = loadAndDispatch(normalElevtors, waitingPeopleArray: &normalWaitingPeopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
        ticks.append(contentsOf: normalTicks)
        
        let expressTicks = loadAndDispatch(expressElevtors, waitingPeopleArray: &expressWaitingPeopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
        ticks.append(contentsOf: expressTicks)
        
        ticks.append("Completed")
        for (index, tick) in ticks.enumerated() {
            print("\(index+1)     \(tick)\n")
        }
        return ticks.count
    }
    
    func loadAndDispatch(_ elevtors: [UrbanElevator], waitingPeopleArray: inout [Person], maxPeople: Int, maxWeight: Int) -> [String] {

        var ticks = [String]()

        repeat {
            for (index, elevator) in elevtors.enumerated() where waitingPeopleArray.count > 0 {
                if elevator.isAvailable {
                    let loadedArray = elevator.load(waitingArray: &waitingPeopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
                    let type = elevator.isExpress ? "Express" : "Normal"
                    ticks.append("Loading \(type) lift in elevator \(index+1) ==> Loaded \(loadedArray.count) people")
                    let dispatchTicks = elevator.startDispatching(persons: loadedArray)
                    ticks.append(contentsOf: dispatchTicks)
                }
            }
            
        } while waitingPeopleArray.count > 0
        
        return ticks
    }
    
    func createLifts(numberOfLifts: Int, isExpress: Bool) -> [UrbanElevator] {
        var elevtors: [UrbanElevator] = []
        for _ in 0...numberOfLifts {
            elevtors.append(UrbanElevator(isExpress: isExpress))
        }
        
        return elevtors
    }
}


