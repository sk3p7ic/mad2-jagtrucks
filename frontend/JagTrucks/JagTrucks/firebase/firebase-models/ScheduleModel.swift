//
//  ScheduleModel.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseFirestore
import Firebase

struct FirebaseMonthlyScheduleEntry {
    let startTime: Timestamp
    let endTime: Timestamp
    let truckId: String
    
    init(data: [String: Any]) {
        startTime = data["start_time"]! as! Timestamp
        endTime = data["end_time"]! as! Timestamp
        truckId = data["truck_id"]! as! String
    }
}

struct FirebaseMonthlySchedule {
    let month: Int8
    let year: Int16
    let listings: [FirebaseMonthlyScheduleEntry]
    
    init(doc: DocumentSnapshot) {
        let docId: [String.SubSequence] = doc.documentID.split(separator: "_")
        month = Int8(docId[1])!
        year = Int16(docId[0])!
        let rawListings: [[String: Any]] = doc.data()!["listings"]! as? [[String: Any]] ?? []
        listings = rawListings.map { FirebaseMonthlyScheduleEntry(data: $0) }
    }
    
    init(qdoc: QueryDocumentSnapshot) {
        let docId: [String.SubSequence] = qdoc.documentID.split(separator: "_")
        month = Int8(docId[1])!
        year = Int16(docId[0])!
        let rawListings: [[String: Any]] = qdoc.data()["listings"]! as? [[String: Any]] ?? []
        listings = rawListings.map { FirebaseMonthlyScheduleEntry(data: $0) }
    }
    
    init() {
        month = 0
        year = 2023
        listings = [FirebaseMonthlyScheduleEntry]()
    }
}
