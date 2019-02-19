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
    var isExpress: Bool
    var liftStartPosition: Int
    
    init(isAvailable: Bool = true, isExpress:Bool = false, liftStartPosition:Int = 1) {
        self.isAvailable = isAvailable
        self.isExpress = isExpress
        self.liftStartPosition = liftStartPosition
    }
    
    func calculateLiftTicks(for peopleWeights: [Int], destinations: [Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int) -> Int {
        
        print("\n\nTick     Lift Status\n")
        
        // Data validation
        if peopleWeights.isEmpty || destinations.isEmpty || peopleWeights.count != destinations.count {
            return 0
        }
        var ticks = [String]()
        var peopleArray = createPeopleArray(for: peopleWeights, destinations: destinations, numberOfFloors: numberOfFloors)
        
        self.isAvailable = false
        
        repeat {
            let arrayBeforeLoading = peopleArray
            
            ticks.append("Loading at floor 1")
            let loadedArray = load(waitingArray: &peopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
            
            // People are waiting, but not able to load
            if peopleArray == arrayBeforeLoading {
                print("Not able to load because of weight limit")
                break
            }
            
            let dispatchTicks = startDispatching(persons: loadedArray)
            ticks.append(contentsOf: dispatchTicks)
            
        } while peopleArray.count > 0
        
        ticks.append("Completed")
        
        self.isAvailable = true
        
        printTicks(ticks: ticks)
        
        return ticks.count
    }
    
    func printTicks(ticks: [String]) {
        for (index, tick) in ticks.enumerated() {
            print("\(index+1)     \(tick)\n")
        }
    }
    
    func createPeopleArray(for peopleWeights: [Int], destinations: [Int], numberOfFloors: Int) -> [Person] {
        
        var peopleArray = [Person]()
        
        for (index, weight) in peopleWeights.enumerated() {
            if destinations[index] > numberOfFloors {
                continue
            }
            peopleArray.append(Person(weight: weight, destination: destinations[index]))
        }
        return peopleArray
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
                    // Reached max people limit
                    break
                }
            } else {
                // Reached max weight limit
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
        // Lift start position
        var liftPosition = self.liftStartPosition
        
        repeat {
            // Guaranteed to have atleast one item
            let unloadPerson = sortedArray[0]
            
            if unloadPerson.destination <= liftPosition {
                break
            }

            // Move lift to first destination
            repeat {
                liftPosition = liftPosition + 1
                if isExpress {
                    if liftPosition % 2 != 0 {
                        liftPosition = liftPosition + 1
                    }
                }
                ticks.append("Moving to floor \(liftPosition)")
            } while liftPosition < unloadPerson.destination
            
            liftPosition = unloadPerson.destination
            
            ticks.append("Unloading at floor \(liftPosition)")
            // Unload all the people with that destination
            sortedArray.forEach { (person) in
                if person.destination == liftPosition {
                    sortedArray.removeFirst()
                }
            }
         // Repeat until loaded people are dispatched
        } while sortedArray.count > 0
        
        // Move the lift back to first floor
        repeat {
            liftPosition = liftPosition-1
            if isExpress && liftPosition != 1 {
                if liftPosition % 2 != 0 {
                    liftPosition = liftPosition - 1
                }
            }
            ticks.append("Moving to floor \(liftPosition)")
        } while liftPosition > 1
        
        return ticks
    }
}
