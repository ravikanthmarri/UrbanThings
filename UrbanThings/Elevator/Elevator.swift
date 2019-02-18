//
//  Elevator.swift
//  UrbanThings
//
//  Created by R K Marri on 18/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

protocol Elevator {
    func calculateLiftTicks(for weights:[Int], destinations:[Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int) -> Int
}

struct Person: Equatable {
    let weight: Int
    let destination : Int
}

struct UrbanElevator: Elevator{
    
    func calculateLiftTicks(for peopleWeights: [Int], destinations: [Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int) -> Int {
        
        if peopleWeights.count != destinations.count {
            return 0
        }
        
        var peopleArray = [Person]()
        
        for (index, weight) in peopleWeights.enumerated() {
            peopleArray.append(Person(weight: weight, destination: destinations[index]))
        }
        
        let loadedArray = load(waitingArray: &peopleArray, maxPeople: maxPeople, maxWeight: maxWeight)
        
        startDispatching(persons: loadedArray)
        
        return 1
    }
    
    func load(waitingArray: inout [Person],maxPeople: Int, maxWeight: Int) -> [Person] {
        
        guard waitingArray.count > 0 else {
            return []
        }
        
        print("Loading at floor 1")
        
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
