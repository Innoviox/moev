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
    var placeID: String
}

struct Annotation: Identifiable {
    var id = UUID()
    
    var location: CLLocationCoordinate2D
}

struct ContentView: View {
    @State private var searchText: String = ""
    
    @State private var selection: UUID?

    @State private var possibilities: [Place] = []
    
    @State private var annotations: [Annotation] = []
    
    @State private var region = MKMapRect()
     

    var body: some View {
        VStack {
            ZStack {
                Map {
                    ForEach(annotations) { a in
                        Marker(coordinate: a.location) {
                            Image(systemName: "mappin")
                        }
                    }
                    
                    UserAnnotation()
                }
                
                HStack {
                    VStack {
                        TextField("Next city...", text: $searchText)
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
                                        addMarker(p: place)
                                        possibilities.removeAll()
                                    }
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
    
    func addMarker(p: Place) {
        APIHandler.shared.get_info(place_id: p.placeID) { data, error in
            guard let d = data else {
                print(error)
                return
            }

            let geom = d.result.geometry.location
            let location = CLLocationCoordinate2D(latitude: geom.lat,
                                                  longitude: geom.lng)
            
            annotations.append(Annotation(location: location))
        }
    }
}

#Preview {
    ContentView()
}
