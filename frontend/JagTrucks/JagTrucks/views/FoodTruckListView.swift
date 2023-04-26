//
//  FoodTruckListView.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/22/23.
//

import SwiftUI

private struct FoodTruckListingItem: View {
    var truckId: String
    @State var truck: FirebaseFoodTruck = FirebaseFoodTruck()
    @State var profileImageUrl = URL(string: "")
    
    var body: some View {
        HStack {
            AsyncImage(url: profileImageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Text("Image")
            }
            Spacer()
            VStack {
                Text("\(truck.name)")
                    .font(.title)
                Text("\(truck.genre)")
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
        .task {
            await updateTruck()
        }
        .padding()
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

struct FoodTruckListView: View {
    var body: some View {
        NavigationView {
            VStack {
                FoodTruckListingItem(truckId: "xOZp8IkysR0evmqWsMyD")
            }
            .navigationTitle("Trucks")
        }
    }
}

struct FoodTruckListView_Previews: PreviewProvider {
    static var previews: some View {
        FoodTruckListView()
    }
}
