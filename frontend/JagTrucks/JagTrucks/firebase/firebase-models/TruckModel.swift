//
//  TruckModel.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseFirestore
import Firebase

enum FirebaseFoodTruckSocialType {
    case website, other
}

struct FirebaseFoodTruckSocial {
    let type: FirebaseFoodTruckSocialType
    let value: String
    
    init(data: [String: String]) {
        switch (data["type"] as String? ?? "") {
        case "website":
            type = FirebaseFoodTruckSocialType.website
        default:
            type = FirebaseFoodTruckSocialType.other
        }
        value = data["value"] as String? ?? ""
    }
}

struct FirebaseFoodTruck {
    let truckID: String
    let genre: String
    let name: String
    let socials: [FirebaseFoodTruckSocial]
    
    init(snap: DocumentSnapshot) {
        truckID = snap.documentID
        let data = snap.data()!
        genre = data["genre"] as? String ?? ""
        name = data["name"] as? String ?? "Could not get name."
        let rawSocials = data["socials"] as? [[String: String]] ?? []
        socials = rawSocials.map {FirebaseFoodTruckSocial(data: $0)}
    }
    
    init() {
        truckID = ""
        genre = ""
        name = "Could not get truck"
        socials = [FirebaseFoodTruckSocial]()
    }
}
