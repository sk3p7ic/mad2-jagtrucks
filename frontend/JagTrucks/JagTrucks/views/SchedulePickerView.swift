//
//  SchedulePickerView.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 4/26/23.
//

import SwiftUI

private struct ScheduleListing: View {
    @EnvironmentObject var truckState: FoodTruckState
    let listing: FirebaseMonthlyScheduleEntry
    @State var thisTruck: FirebaseFoodTruck = FirebaseFoodTruck()
    @State var profileImageUrl = URL(string: "")
    
    var body: some View {
        VStack {
            VStack {
                    AsyncImage(url: profileImageUrl) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Text("")
                    }
                Text(thisTruck.name)
                    .font(.title)
                Text("Start: \(listing.startTime.dateValue().formatted(.dateTime))")
                Text("End: \(listing.endTime.dateValue().formatted(.dateTime))")
            }
            .padding()
        }
        .background(Color.yellow)
        .task {
            await getTruckInfo()
        }
    }
    
    func getTruckInfo() async {
        thisTruck = await truckState.getTruck(truckId: listing.truckId) ?? FirebaseFoodTruck()
        fbStorageRef.child("/trucks/\(listing.truckId).jpg").downloadURL { (url, error) in
            if error != nil {
                print(error as Any)
                return
            }
            profileImageUrl = url
        }
    }
}

struct SchedulePickerView: View {
    @EnvironmentObject var scheduleState: ScheduleState
    @EnvironmentObject var truckState: FoodTruckState
    @State var month: Int8 = 4
    @State var year: Int16 = 2023
    @State var selectedDate = Date()
    private let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]

    
    func getKey(m: Binding<Int8>, y: Binding<Int16>) -> String {
        return String(format: "%d_%02d", y.wrappedValue, m.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                DatePicker(
                    "Month",
                    selection: $selectedDate,
                    displayedComponents: [.date]
                )
                .datePickerStyle(.graphical)
                .onChange(of: selectedDate) { v in
                    let month_str = v.formatted(.dateTime.month())
                    month = Int8((months.firstIndex(of: month_str) ?? 0) + 1)
                    year = Int16(v.formatted(.dateTime.year())) ?? 2023
                }
                Text("This month's venders").font(.headline)
                
                ForEach(scheduleState.schedule[getKey(m: $month, y: $year)]?.listings ?? [], id: \.truckId) { listing in
                    NavigationLink{
                        FoodTruckView(truckId: listing.truckId)
                            .environmentObject(truckState)
                        
                    } label: {
                        ScheduleListing(listing: listing)
                            .environmentObject(truckState)
                    }
                }
                
            }
            .task {
                await scheduleState.getAllMonthlySchedules()
            }
            .navigationTitle("View Schedules")
        }
    }
}

struct SchedulePickerView_Previews: PreviewProvider {
    static var previews: some View {
        SchedulePickerView().environmentObject(masterSchedule).environmentObject(masterTruckState)
    }
}

/*

    ForEach(truckId: listing.truckId) ?? FirebaseFoodTruck(){ truck in trucks
      NavigationLink {
    FoodTruckView(truckId:listing.truckId )
        .environmentObject()
} label: {
  ScheduleListing
 }
*/
