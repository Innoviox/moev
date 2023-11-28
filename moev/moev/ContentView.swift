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
    
    var location: CLLocationCoordinate2D?
    var name: String
}

struct TextDisplay: View {
    @State public var searchText: String
    @State private var possibilities: [Place] = []
    
    public var placeHolder: String = "Next city..."
    public var addMarker: (Place) -> Void
    
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

struct ContentView: View {
    @State private var searchText: String = ""
    
    @State private var selection: UUID?
    
//    @StateObject var locationManager = LocationManager { l in userLocation = l}
    
    @State private var userLocation: CLLocationCoordinate2D?
    
    @State private var locations: [Annotation] = [
        Annotation(location: nil, name: "Current location"),
//        Annotation(
    ]
    
    @State private var region = MKMapRect()
     

    var body: some View {
        VStack {
            ZStack {
                Map {
                    ForEach(locations.filter { i in i.location != nil}) { a in
                        Marker(coordinate: a.location!) {
                            Image(systemName: "mappin")
                        }
                    }
                    
                    UserAnnotation()
                }
                
                HStack {
                    VStack {
                        ForEach(locations) { a in
                            TextDisplay(searchText: a.name, addMarker: addMarker)
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
    
    func addMarker(p: Place) {
        APIHandler.shared.get_info(place_id: p.placeID) { data, error in
            guard let d = data else {
                print(error)
                return
            }

            let geom = d.result.geometry.location
            let location = CLLocationCoordinate2D(latitude: geom.lat,
                                                  longitude: geom.lng)
            
            locations.append(Annotation(location: location, name: d.result.name))
        }
    }
}

#Preview {
    ContentView()
}
