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
    
    func getMonth(month: Int8, year: Int32) async -> FirebaseMonthlySchedule {
        let key = String(format: "%d_%02d", year, month)
        let sched = schedule[key]
        
        if (sched != nil) {
            return sched!
        }
        
        let newTruck = await getScheduleForMonth(month: month, year: year)
        schedule[key] = newTruck != nil ? newTruck : FirebaseMonthlySchedule()
        return schedule[key]!
    }
    
    func getAllMonthlySchedules() async {
        let scheds = await getAllScheduleItems()
        print(scheds)
        for s in scheds {
            let key = String(format: "%d_%02d", s.year, s.month)
            schedule[key] = s
        }
    }
}

let masterSchedule = ScheduleState()
