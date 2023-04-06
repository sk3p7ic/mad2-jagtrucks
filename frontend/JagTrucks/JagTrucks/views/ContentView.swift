//
//  ContentView.swift
//  JagTrucks
//
//  Created by Joshua Ibrom on 3/24/23.
//

import SwiftUI

struct ContentView: View {
    func t() -> String {
        let truck = masterTruckState.getTruck(truckId: "xOZp8IkysR0evmqWsMyD")
        print("\(truck)")
        return "JagTrucks"
    }
    var body: some View {
        VStack {
            Text(t())
                .font(.largeTitle)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
