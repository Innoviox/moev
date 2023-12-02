//
//  TextDisplay.swift
//  moev
//
//  Created by Simon Chervenak on 11/28/23.
//

import SwiftUI
import MapKit

struct Place: Identifiable {
    var id = UUID()
    
    var name: String
    var placeID: String
}


struct TextDisplay: View {
    @Binding public var annotation: Annotation
    @Binding public var searching: Bool
    @Binding public var searchingNotAnimated: Bool
    @State private var possibilities: [Place] = []
    
    public var getDirections: (Int) -> Void
    
    @State private var justChanged: Bool = false
    
    var body: some View {
        VStack {
            TextField(annotation.placeHolder, text: $annotation.name, onEditingChanged: { isEditing in
                withAnimation(Animation.easeInOut(duration: 0.5)) {
                        searching = true
                    }
                
                withAnimation(Animation.easeInOut(duration: 0.2)) {
                        searchingNotAnimated = true
                    }
                })
                .textFieldStyle(.roundedBorder)
                .onChange(of: annotation.name) { o, n in
                    if justChanged {
                        justChanged = false
                    } else {
                        updatePossibilities()
                    }
                }
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
                                        addMarker(p: place)
                                        possibilities.removeAll()
                                    }
                                
                                Spacer()
                            }
                        }
                    }
                    .offset(x: 0, y: 34)
                }
        }
        .zIndex(Double(possibilities.count))
    }
    
    func updatePossibilities() {
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
    
    func addMarker(p: Place) {
        APIHandler.shared.get_info(place_id: p.placeID) { data, error in
            guard let d = data else {
                print(error)
                return
            }

            let geom = d.result.geometry.location
            let location = CLLocationCoordinate2D(latitude: geom.lat,
                                                  longitude: geom.lng)
            
            annotation.name = d.result.name
            annotation.location = location
            annotation.placeID = p.placeID
            
            justChanged = true
            
            getDirections(annotation.id)
        }
    }
}
