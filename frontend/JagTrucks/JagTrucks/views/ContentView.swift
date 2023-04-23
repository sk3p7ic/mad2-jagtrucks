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
                .tabItem {
                    Label("Trucks", systemImage: "box.truck")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
