//
//  ContentView.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State public var searching: Bool
    
    var body: some View {
        ZStack {
            MapView(searching: $searching)
            
            if searching {
                GeometryReader { geometry in
                    Text("Test")
                        .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
        }
    }
}

#Preview {
    ContentView(searching: false)
}
