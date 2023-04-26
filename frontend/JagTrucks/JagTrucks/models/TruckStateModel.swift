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
    
    func getTruck(truckId: String) async -> FirebaseFoodTruck? {
        var truck: FirebaseFoodTruck? = nil
        truck = trucks.first(where: { $0.truckID == truckId })
        
        if (truck == nil) {
            let newTruck = await getFoodTruckFromFirestore(truckId: truckId)
            if newTruck != nil {
                trucks.append(newTruck!)
            }
            truck = trucks.first(where: { $0.truckID == truckId })
        }
        
        return truck
    }
    
    func getAllTruckIds() async {
        let allTrucks = await getAllFoodTrucksInCollection()
        for t in allTrucks {
            trucks.append(t)
        }
    }
}

let masterTruckState = FoodTruckState()
