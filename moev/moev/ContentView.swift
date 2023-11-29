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
}

struct ContentView: View {
    @State private var selection: UUID?
    
    @StateObject var locationManager = LocationManager()
    
    @State private var userLocation: CLLocationCoordinate2D?
    
    @State private var topAnnotation = Annotation(name: "")
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
                        TextDisplay(annotation: $topAnnotation,
                                    placeHolder: "Current location")
                        
                        ForEach($annotations) { $a in
                            TextDisplay(annotation: $a)
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
}

#Preview {
    ContentView()
}
