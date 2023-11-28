//
//  ContentView.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State private var searchText: String = ""
    var body: some View {
        VStack {
            HStack {
                TextField("Next city...", text: $searchText)
                Image(systemName: "location.magnifyingglass")
            }
            Map {
                
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
