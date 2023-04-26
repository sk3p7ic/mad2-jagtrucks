//
//  Schedules.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation
import FirebaseFirestore
import Firebase

func getScheduleForMonth(month: Int8, year: Int32) async -> FirebaseMonthlySchedule? {
    let docId = String(format: "%d_%02d", year, month)
    let doc = try? await db.collection("schedules").document(docId).getDocument()
    if doc == nil {
        print("Document not found!")
        return nil
    }
    return FirebaseMonthlySchedule(doc: doc!)
}

func getAllScheduleItems() async -> [FirebaseMonthlySchedule] {
    print("Getting the schedule items")
    var scheds = [FirebaseMonthlySchedule]()
    let docs = try? await db.collection("schedules").getDocuments()
    print(docs)
    if docs == nil {
        print("Could not get schedules")
        return [FirebaseMonthlySchedule]()
    }
    for d in docs!.documents {
        print(d)
        scheds.append(FirebaseMonthlySchedule(qdoc: d))
    }
    return scheds
}
