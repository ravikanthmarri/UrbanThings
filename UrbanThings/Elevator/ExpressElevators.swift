//
//  ExpressElevators.swift
//  UrbanThings
//
//  Created by R K Marri on 19/02/2019.
//  Copyright © 2019 R K Marri. All rights reserved.
//

import Foundation

protocol ExpressAndNormalElevators {
    
    func calculateLiftTicks(for people:[Int], destinations:[Int], numberOfFloors: Int, maxPeople: Int, maxWeight: Int, numberOfNormalLifts: Int, numberOfExpressLifts: Int) -> Int
 
}

//class MultipleMixedElevators: ExpressAndNormalElevators {
//
//    var elevtors: [UrbanElevator] = []
//
//
//
//
//
//}


