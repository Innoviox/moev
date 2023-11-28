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
                    .textFieldStyle(.roundedBorder)
                    .onChange(of: searchText) { (oldValue, newValue) in
                        APIHandler.shared.autocomplete(query: searchText) { data, response, error in
                            print(data)
                            print(response)
                            print(error)
                        }
                    }
                Image(systemName: "location.magnifyingglass")
            }
            
            ZStack {
                Map {
                    
                }
                
                VStack(alignment: .leading) {
                    ForEach(possibilities) { i in
                        HStack {
                            Text(i.name)
                            Spacer()
                        }
                    }

                    Spacer()
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
