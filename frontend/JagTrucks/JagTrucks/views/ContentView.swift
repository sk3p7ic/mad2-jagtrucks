//
//  ContentView.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 3/24/23.
//

import SwiftUI

private struct HomeView: View {
    var body: some View {
        NavigationView {
            Text("Hello world!")
                .navigationTitle("Home")
        }
    }
}

struct ContentView: View {
    @ObservedObject var truckState = FoodTruckState()
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            HomeView()
                .tabItem {
                    Label("Schedule", systemImage: "calendar")
                }
            FoodTruckListView()
                .environmentObject(truckState)
                .tabItem {
                    Label("Trucks", systemImage: "box.truck")
                }
        }
        .task {
            await fetchTrucks()
            print(truckState.trucks)
        }
    }
    
    func fetchTrucks() async {
        await truckState.getAllTruckIds()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
