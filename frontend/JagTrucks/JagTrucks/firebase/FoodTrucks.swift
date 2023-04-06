//
//  FoodTrucks.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseFirestore
import Firebase

func getFoodTruckFromFirestore(truckId: String) {
    let docRef = db.collection("trucks").document(truckId)
    
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let truck = FirebaseFoodTruck(snap: document)
            masterTruckState.addTruck(truck: truck)
        }
        else {
            print("Document not found!")
        }
    }
}
