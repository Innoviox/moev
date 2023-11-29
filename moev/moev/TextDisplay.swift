//
//  TextDisplay.swift
//  moev
//
//  Created by Simon Chervenak on 11/28/23.
//

import SwiftUI

struct Place: Identifiable {
    var id = UUID()
    
    var name: String
    var placeID: String
}


struct TextDisplay: View {
    @State public var annotation: Annotation
    @State private var possibilities: [Place] = []
    
    public var placeHolder: String = "Next location..."
    public var addMarker: (Place) -> Void = { p in }
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $annotation.name)
                .textFieldStyle(.roundedBorder)
                .onChange(of: annotation.name, updatePossibilities)
                .overlay(alignment: .topLeading) {
                    VStack {
                        ForEach(possibilities) { place in
                            HStack {
                                Text(place.name)
                                    .frame(maxWidth: .infinity)
                                    .border(.black)
                                    .background(.white)
                                    .lineLimit(1)
                                    .onTapGesture {
                                        addMarker(place)
                                        possibilities.removeAll()
                                    }
                                Spacer()
                            }
                        }
                    }
                    .offset(x: 0, y: 34)
                }
        }.zIndex(Double(possibilities.count))
    }
    
    func updatePossibilities(oldValue: any Equatable, newValue: any Equatable) {
        APIHandler.shared.autocomplete(query: annotation.name) { data, error in
            guard let places = data else {
                print(error)
                return
            }
            
            possibilities = places.predictions.map { place in
                return Place(name: place.description, placeID: place.place_id)
            }
        }
    }
}
