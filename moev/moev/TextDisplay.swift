//
//  TextDisplay.swift
//  moev
//
//  Created by Simon Chervenak on 11/28/23.
//

import SwiftUI

struct TextDisplay: View {
    @State public var searchText: String = ""
    @State private var possibilities: [Place] = []
    
    public var placeHolder: String = "Next city..."
    public var addMarker: (Place) -> Void = { p in }
    
    var body: some View {
        VStack {
            TextField(placeHolder, text: $searchText)
                .textFieldStyle(.roundedBorder)
                .onChange(of: searchText, updatePossibilities)
            
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
            Spacer()
        }
    }
    
    func updatePossibilities(oldValue: any Equatable, newValue: any Equatable) {
        APIHandler.shared.autocomplete(query: searchText) { data, error in
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

//struct TopTextDisplay: TextDisplay {
//    public var placeHolder
//}
