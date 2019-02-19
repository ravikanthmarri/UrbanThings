//
//  Elevator.swift
//  UrbanThings
//
//  Created by R K Marri on 18/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

protocol Elevator {
    
    var isAvailable: Bool { get set }
    func calculateLiftTicks(for weights:[Int], destinations:[Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int) -> Int

}

struct Person: Equatable {
    let weight: Int
    let destination : Int
}

class UrbanElevator: Elevator {
    
    var isAvailable: Bool
    
    init(isAvailable: Bool = true) {
        self.isAvailable = isAvailable
    }
    
    func calculateLiftTicks(for peopleWeights: [Int], destinations: [Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int) -> Int {
        
        print("\n\nTick     Lift Status\n")
        
        if peopleWeights.isEmpty || destinations.isEmpty || peopleWeights.count != destinations.count {
            return 0
        }
        var ticks = [String]()
        var peopleArray = [Person]()
        
        for (index, weight) in peopleWeights.enumerated() {
            peopleArray.append(Person(weight: weight, destination: destinations[index]))
        }
        
        self.isAvailable = false
        
        repeat {
            let arrayBeforeLoading = peopleArray
            
            ticks.append("Loading at floor 1")
            let loadedArray = load(waitingArray: &peopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
            
            if peopleArray == arrayBeforeLoading {
                print("Not able to load because of weight limit")
                break
            }
            
            let dispatchTicks = startDispatching(persons: loadedArray)
            ticks.append(contentsOf: dispatchTicks)
            
        } while peopleArray.count > 0
        
        ticks.append("Completed")
        
        self.isAvailable = true
        
        for (index, tick) in ticks.enumerated() {
            print("\(index+1)     \(tick)\n")
        }
        
        return ticks.count
    }
    
    func load(waitingArray: inout [Person],maxPeople: Int, maxWeight: Int) -> [Person] {
        
        guard waitingArray.count > 0 else {
            return []
        }
        var loadedArray = [Person]()
        var loadedWeight = 0
        
        while waitingArray.count > 0 {
            let firstPerson = waitingArray[0]
            
            if loadedWeight + firstPerson.weight <= maxWeight {
                loadedWeight += firstPerson.weight
                loadedArray.append(firstPerson)
                waitingArray.removeFirst()
                if loadedArray.count >= maxPeople {
                    break
                }
            } else {
                break
            }
        }
        
        return loadedArray
    }
    
    func startDispatching(persons:[Person]) -> [String]{
        
        if persons.isEmpty {
            return []
        }
        
        var ticks = [String]()
        // Sort the array by destinations for dispatch
        var sortedArray = persons.sorted(by: { $0.destination < $1.destination })
        var liftPosition = 1
        
        repeat {
            let unloadPerson = sortedArray[0]
            
            if unloadPerson.destination <= liftPosition {
                break
            }
            
            for index in liftPosition+1...unloadPerson.destination {
                ticks.append("Moving to floor \(index)")
            }
            liftPosition = unloadPerson.destination
            ticks.append("Unloading at floor \(liftPosition)")
            sortedArray.forEach { (person) in
                if person.destination == liftPosition {
                    sortedArray.removeFirst()
                }
            }
        } while sortedArray.count > 0
        
        for index in (1...liftPosition-1).reversed() {
            ticks.append("Moving to floor \(index)")
        }
        return ticks
    }
}
