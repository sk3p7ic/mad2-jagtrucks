//
//  FoodTruckView.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/13/23.
//

import SwiftUI

struct FoodTruckView: View {
    var truckId: String
    @State var truck: FirebaseFoodTruck = FirebaseFoodTruck()

    var body: some View {
        VStack {
            Text(truck.name)
        }
        .task {
            await updateTruck()
        }
    }
    
    func updateTruck() async {
        let retrievedTruck = await masterTruckState.getTruck(truckId: truckId)
        if retrievedTruck != nil {
            truck = retrievedTruck!
        }
        print(truck as Any)
    }
}

struct FoodTruckView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTruckView(truckId: "xOZp8IkysR0evmqWsMyD")
    }
}
