//
//  ScheduleStateModel.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/6/23.
//

import Foundation

class ScheduleState: ObservableObject {
    @Published var schedule: Dictionary<String, FirebaseMonthlySchedule>
    
    init() {
        schedule = [:]
    }
    
    func addMonth(key: String, sched: FirebaseMonthlySchedule) {
        schedule[key] = sched
    }
    
    func getMonth(month: Int8, year: Int32) -> FirebaseMonthlySchedule {
        let key = String(format: "%d_%02d", year, month)
        let sched = schedule[key]
        
        if (sched != nil) {
            return sched!
        }
        
        getScheduleForMonth(month: month, year: year)
        return schedule[key]!
    }
}

let masterSchedule = ScheduleState()
