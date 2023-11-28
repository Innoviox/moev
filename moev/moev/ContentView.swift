//
//  ContentView.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID()
    
    var name: String
}

struct ContentView: View {
    @State public var searchText: String = ""
    
    @State public var selection: UUID?

    
    let possibilities = [Place(name: "place 1"), Place(name: "Place 2")]
    
    var body: some View {
        VStack {
            HStack {
                TextField("Next city...", text: $searchText)
                Image(systemName: "location.magnifyingglass")
            }
            
            List(possibilities, selection: $selection) {
                Text($0.name)
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
