//
//  FoodTruckView.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/13/23.
//

import SwiftUI
import FirebaseStorage

struct FoodTruckView: View {
    var truckId: String
    @State var truck: FirebaseFoodTruck = FirebaseFoodTruck()
    @State var profileImageUrl = URL(string: "")

    var body: some View {
        VStack {
            AsyncImage(url: profileImageUrl)
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
            fbStorageRef.child("/trucks/\(truckId).jpg").downloadURL { (url, error) in
                if error != nil {
                    print(error as Any)
                    return
                }
                profileImageUrl = url
            }
        }
        print(truck as Any)
    }
}

struct FoodTruckView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTruckView(truckId: "xOZp8IkysR0evmqWsMyD")
    }
}
