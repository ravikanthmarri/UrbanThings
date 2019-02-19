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
        
        repeat {
            
            for (index, elevator) in normalElevtors.enumerated() where normalWaitingPeopleArray.count > 0 {
                if elevator.isAvailable {
                    let loadedArray = elevator.load(waitingArray: &normalWaitingPeopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
                    ticks.append("Loading normal lift in elevator \(index+1) ==> Loaded \(loadedArray.count) people")
                    let dispatchTicks = elevator.startDispatching(persons: loadedArray)
                    ticks.append(contentsOf: dispatchTicks)
                }
            }
            
        } while normalWaitingPeopleArray.count > 0

        repeat {
            
            for (index, elevator) in expressElevtors.enumerated() where expressWaitingPeopleArray.count > 0 {
                if elevator.isAvailable {
                    let loadedArray = elevator.load(waitingArray: &expressWaitingPeopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
                    ticks.append("Loading express lift in elevator \(index+1) ==> Loaded \(loadedArray.count) people")
                    let dispatchTicks = elevator.startDispatching(persons: loadedArray)
                    ticks.append(contentsOf: dispatchTicks)
                }
            }
            
        } while expressWaitingPeopleArray.count > 0
        
        ticks.append("Completed")
        
        for (index, tick) in ticks.enumerated() {
            print("\(index+1)     \(tick)\n")
        }
        return ticks.count
    }
    
    func createLifts(numberOfLifts: Int, isExpress: Bool) -> [UrbanElevator] {
        var elevtors: [UrbanElevator] = []
        for _ in 0...numberOfLifts {
            elevtors.append(UrbanElevator(isExpress: isExpress))
        }
        return elevtors
    }
}


