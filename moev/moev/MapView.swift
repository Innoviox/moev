//
//  MapView.swift
//  moev
//
//  Created by Simon Chervenak on 12/1/23.
//

import SwiftUI
import MapKit

struct Annotation: Identifiable {
    var id: Int
    
    var location: CLLocationCoordinate2D?
    var name: String
    var placeID: String = ""
    var placeHolder: String = "Next location..."
}

struct UIPolyline: Identifiable {
    var id: Int
    
    var polyline: MKPolyline
}

struct MapView: View {
    @State private var selection: UUID?
    
    @Binding public var searching: Bool
    
    @StateObject var locationManager = LocationManager()
        
    @State private var annotations: [Annotation] = [
        Annotation(id: 0, name: "", placeHolder: "Current location"),
        Annotation(id: 1, name: "")
    ]
    
    @State private var polylines: [UIPolyline] = []
    
    @State private var region = MKMapRect()

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    GeometryReader { geometry in
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
                        .frame(height: geometry.size.height / 2)
                        
                        HStack {
                            VStack {
                                ForEach($annotations) { $a in
                                    TextDisplay(annotation: $a, searching: $searching, getDirections: getDirections)
                                }
                                
                                Spacer()
                            }
                            
                            VStack {
                                Button(action: {
                                    annotations.append(Annotation(id: annotations.count, name: ""))
                                }, label: {
                                    Image(systemName: "plus.app")
                                })
                                
                                Spacer()
                            }
                        }
                        .offset(CGSize(width: 0.0, height: geometry.size.height / 2 - 50))
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    }
                }
            }
        }
    }
    
    func getDirections(senderID: Int) {
        if senderID > 0 {
            getDirections(id1: senderID - 1, id2: senderID)
        }
        
        if senderID < annotations.count - 1 {
            getDirections(id1: senderID, id2: senderID + 1)
        }
    }
    
    func getDirections(id1: Int, id2: Int) {
        let origin = getWaypoint(id1)
        let destination = getWaypoint(id2)
        
        guard let o = origin, let d = destination else {
            return // todo
        }
        
        updatePolylines(withID: id1, newPolyline: emptyPolyline())
        
        APIHandler.shared.directions(origin: o, destination: d) { results, error in
            guard let route = results else {
                print(error)
                return
            }
            
            let polyline = route.polyline.decode()
            updatePolylines(withID: id1, newPolyline: polyline)
        }
    }
    
    func getWaypoint(_ id: Int) -> Waypoint? {
        let coord = id == 0 ? locationManager.lastLocation?.coordinate : annotations[id].location
        return coord?.toWaypoint()
    }
    
    func updatePolylines(withID id: Int, newPolyline: MKPolyline) {
        for i in polylines.indices {
            if polylines[i].id == id {
                polylines[i].polyline = newPolyline
                return
            }
        }
        polylines.append(UIPolyline(id: id, polyline: newPolyline))
    }
    
    func emptyPolyline() -> MKPolyline {
        return MKPolyline(coordinates: [], count: 0)
    }
}
