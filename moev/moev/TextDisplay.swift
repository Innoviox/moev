//
//  TextDisplay.swift
//  moev
//
//  Created by Simon Chervenak on 11/28/23.
//

import SwiftUI
import MapKit

struct TextDisplay: View {
    @Binding public var annotation: Annotation
    @Binding public var searching: Bool
    @Binding public var searchingFastAnimated: Bool
    @Binding public var searchingSlowAnimated: Bool
    @Binding public var possibilities: [Place]
    
    public var getDirections: (Int) -> Void
    
    @State private var justChanged: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Image(systemName: "magnifyingglass")
                    .opacity(searchingSlowAnimated ? 1 : 0)
                    .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0))
                TextField(annotation.placeHolder, text: $annotation.name, onEditingChanged: { isEditing in
                    withAnimation(Animation.easeInOut(duration: 0.5)) {
                        searching = true
                    }
                    
                    withAnimation(Animation.easeInOut(duration: 0.2)) {
                        searchingFastAnimated = true
                    }
                    
                    withAnimation(Animation.easeInOut(duration: 0.5).delay(0.3)) {
                        searchingSlowAnimated = true
                    }
                })
                .onChange(of: annotation.name) { o, n in
                    if justChanged {
                        justChanged = false
                    } else {
                        updatePossibilities()
                    }
                }
                .frame(width: 2 * geometry.size.width / 3)
                .padding(10)
                .border(UIColor.Theme.searchColor, width: 10)
                .background(UIColor.Theme.searchColor)
                // todo shadow
//                .shadow(
//                    color: .primary,
//                    radius: CGFloat(5),
//                    x: CGFloat(0), y: CGFloat(0))
            }
            .zIndex(Double(possibilities.count))
        }
    }
    
    func updatePossibilities() {
        APIHandler.shared.autocomplete(query: annotation.name) { data, error in
            guard let places = data else {
                print(error)
                return
            }
            
            possibilities = places.predictions.map { place in
                return Place(main_text: place.structured_formatting.main_text, secondary_text: place.structured_formatting.secondary_text, placeID: place.place_id)
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
