//
//  MultipleElevators.swift
//  UrbanThings
//
//  Created by R K Marri on 18/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

protocol MultipleElevators {
    
    func calculateLiftTicks(for people:[Int], destinations:[Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int, numberOfLifts: Int) -> Int
    
}

class MultipleUrbanElevators: MultipleElevators {
    
    var elevtors: [UrbanElevator] = []
    
    func calculateLiftTicks(for people:[Int], destinations:[Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int, numberOfLifts: Int) -> Int {

        if people.isEmpty || destinations.isEmpty || people.count != destinations.count {
            return 0
        }

        print("\n\nTick     Lift Status\n")
        
        var ticks = [String]()
        
        // Create elevators
        for _ in 0...numberOfLifts {
            self.elevtors.append(UrbanElevator())
        }
        
        var waitingPeopleArray = [Person]()
        
        // Create waiting people array
        for (index, weight) in people.enumerated() {
            waitingPeopleArray.append(Person(weight: weight, destination: destinations[index]))
        }

        repeat {
            // Loop through the elevators to load and dispatch
            for (index, elevator) in elevtors.enumerated() where waitingPeopleArray.count > 0 {
                // Chcek if lift is available
                if elevator.isAvailable {
                    let loadedArray = elevator.load(waitingArray: &waitingPeopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
                    ticks.append("Loading at floor 1 in elevator \(index+1) ==> Loaded \(loadedArray.count) people")
                    let dispatchTicks = elevator.startDispatching(persons: loadedArray)
                    ticks.append(contentsOf: dispatchTicks)
                }
            }
        } while waitingPeopleArray.count > 0
        
        ticks.append("Completed")
        
        for (index, tick) in ticks.enumerated() {
            print("\(index+1)     \(tick)\n")
        }
        return ticks.count
    }
    
}

