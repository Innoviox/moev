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
                
                HStack {
                    VStack {
                        TextField("Next city...", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: searchText, updatePossibilities)
                        
                        ForEach(possibilities) { i in
                            HStack {
                                Text(i.name)
                                    .frame(maxWidth: .infinity)
                                    .border(.black)
                                    .background(.white)
                                Spacer()
                            }
                        }
                        Spacer()
                    }
                    
                    VStack {
                        Image(systemName: "location.magnifyingglass")
                        
                        Spacer()
                    }
                }
            }
        }
        .padding()
    }
    
    func updatePossibilities(oldValue: any Equatable, newValue: any Equatable) {
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
}

#Preview {
    ContentView(possibilities: [Place(name: "a"), Place(name: "b")])
}
