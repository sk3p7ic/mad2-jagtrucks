//
//  Schedules.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseFirestore
import Firebase

func getScheduleForMonth(month: Int8, year: Int32) {
    let docId = String(format: "%d_%02d", year, month)
    let docRef = db.collection("schedules").document(docId)
    
    
    docRef.getDocument { (document, error) in
        if let document = document, document.exists {
            let sched = FirebaseMonthlySchedule(doc: document)
            masterSchedule.addMonth(key: docId, sched: sched)
        }
        else {
            print("Document not found!")
        }
    }
}
