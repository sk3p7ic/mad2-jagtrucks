//
//  TruckStateModel.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation

class FoodTruckState: ObservableObject {
    @Published var trucks: [FirebaseFoodTruck]
    
    init() {
        trucks = [FirebaseFoodTruck]()
    }
    
    func addTruck(truck: FirebaseFoodTruck) {
        trucks.append(truck)
        print("\(trucks)")
    }
    
    func getTruck(truckId: String) -> FirebaseFoodTruck? {
        var truck: FirebaseFoodTruck? = nil
        truck = trucks.first(where: { $0.truckID == truckId })
        
        if (truck == nil) {
            getFoodTruckFromFirestore(truckId: truckId)
            truck = trucks.first(where: { $0.truckID == truckId })
        }
        
        return truck
    }
}

let masterTruckState = FoodTruckState()
