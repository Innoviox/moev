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

struct ContentView: View {    
    @State private var selection: UUID?
    
    @StateObject var locationManager = LocationManager()
    
    @State private var userLocation: CLLocationCoordinate2D?
    
    @State private var annotations: [Annotation] = [Annotation(name: "")]
    
    @State private var region = MKMapRect()
     

    var body: some View {
        VStack {
            ZStack {
                Map {
                    ForEach(annotations.filter { i in i.location != nil }) { a in
                        Marker(coordinate: a.location!) {
                            Image(systemName: "mappin")
                        }
                    }
                    
                    UserAnnotation()
                }
                
                HStack {
                    VStack {
                        TextDisplay(placeHolder: "Current location")
                        
                        ForEach(annotations.indices) { i in
                            TextDisplay(searchText: annotations[i].name, addMarker: addMarker(i: i))
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
    
    func addMarker(i: Int) -> (Place) -> Void {
        return { p in
            APIHandler.shared.get_info(place_id: p.placeID) { data, error in
                guard let d = data else {
                    print(error)
                    return
                }

                let geom = d.result.geometry.location
                let location = CLLocationCoordinate2D(latitude: geom.lat,
                                                      longitude: geom.lng)
                
                annotations[i].location = location
            }
        }
    }
}

// https://stackoverflow.com/questions/56517610/conditionally-use-view-in-swiftui
extension View {
   @ViewBuilder
   func `if`<Content: View>(_ conditional: Bool, content: (Self) -> Content) -> some View {
        if conditional {
            content(self)
        } else {
            self
        }
    }
}

#Preview {
    ContentView()
}
