//
//  ContentView.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import SwiftUI
import MapKit

struct Annotation: Identifiable {
    var id = UUID()
    
    var location: CLLocationCoordinate2D?
    var name: String
    var placeID: String = ""
}

struct UIPolyline: Identifiable {
    var id = UUID()
    
    var polyline: MKPolyline
}

struct ContentView: View {
    @State private var selection: UUID?
    
    @StateObject var locationManager = LocationManager()
        
    @State private var topAnnotation = Annotation(name: "")
    @State private var annotations: [Annotation] = [Annotation(name: "")]
    @State private var polylines: [UIPolyline] = []
    
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
                    
                    ForEach(polylines) { p in
                        MapPolyline(p.polyline)
                            .stroke(.blue, lineWidth: 2.0)
                    }
                    
                    UserAnnotation()
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                    MapScaleView()
                }
                
                HStack {
                    VStack {
                        TextDisplay(annotation: $topAnnotation,
                                    placeHolder: "Current location", getDirections: getDirections)
                        
                        ForEach($annotations) { $a in
                            TextDisplay(annotation: $a, getDirections: getDirections)
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        Button(action: {
                            annotations.append(Annotation(name: ""))
                        }, label: {
                            Image(systemName: "plus.app")
                        })
                        
                        Spacer()
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
            }
        }
    }
    
    func getDirections() {
        let origin = locationManager.lastLocation!.coordinate.toWaypoint()
        let destination = annotations[0].location!.toWaypoint() // todo not just 0th annotation
        APIHandler.shared.directions(origin: origin, destination: destination) { results, error in
            guard let route = results else {
                print(error)
                return
            }
            
            let polyline = route.polyline.decode()
            polylines.append(UIPolyline(polyline: polyline))
        }
    }
}

#Preview {
    ContentView()
}
