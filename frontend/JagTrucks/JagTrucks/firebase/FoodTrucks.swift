//
//  FoodTrucks.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseFirestore
import Firebase

func getFoodTruckFromFirestore(truckId: String) async -> FirebaseFoodTruck? {
    let doc = try? await db.collection("trucks").document(truckId).getDocument()
    if doc == nil {
        print("Document not found")
        return nil
    }
    return FirebaseFoodTruck(snap: doc!)
}

func getAllFoodTrucksInCollection() async -> [FirebaseFoodTruck] {
    var trucks = [FirebaseFoodTruck]()
    let docs = try? await db.collection("trucks").getDocuments()
    if docs == nil {
        print("Could not get documents")
        return [FirebaseFoodTruck]()
    }
    for d in docs!.documents {
        trucks.append(FirebaseFoodTruck(qsnap: d))
    }
    return trucks
}
