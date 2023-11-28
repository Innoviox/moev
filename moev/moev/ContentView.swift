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

    @State public var possibilities: [Place] = []

    var body: some View {
        VStack {
            ZStack {
                Map {
                    
                }
                
                VStack(alignment: .leading) {
                    HStack {
                        TextField("Next city...", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: searchText) { (oldValue, newValue) in
                                APIHandler.shared.autocomplete(query: searchText) { data, response, error in
                                    
                                    guard let d = data else {
                                        print(error)
                                        return
                                    }
                                    
                                    let cities = try! JSONSerialization.jsonObject(with: d, options: []) as! [String : Any]
                                    
                                    possibilities = (cities["predictions"] as! [[String: Any]]).map { city in
                                        return Place(name: city["description"] as! String)
                                    }
                                }
                            }
                        Image(systemName: "location.magnifyingglass")
                    }
                    
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
