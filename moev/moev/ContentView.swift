//
//  ContentView.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import SwiftUI
import MapKit

struct Annotation: Identifiable {
    var id: Int
    
    var location: CLLocationCoordinate2D?
    var name: String
    var placeID: String = ""
    var placeHolder: String = "Next location..."
    var justChanged: Bool = false
}

struct UIPolyline: Identifiable {
    var id: Int
    
    var polyline: MKPolyline
}

struct UIPlace: Identifiable {
    var id = UUID()
    
    var main_text: String
    var secondary_text: String
    var placeID: String
}

struct UIRoutes: Identifiable {
    var id: Int
    var routes: [Route]
}

struct ContentView: View {
    @State private var selection: UUID?
    
    @State public var searching: Bool = false
    @State public var searchingFastAnimated: Bool = false
    @State public var searchingSlowAnimated: Bool = false
    
    @StateObject var locationManager = LocationManager()
    
    @State private var possibilities: [UIPlace] = []
        
    @State private var annotations: [Annotation] = [
        Annotation(id: 0, name: "", placeHolder: "Current location"),
        Annotation(id: 1, name: "")
    ]
    
    @State private var polylines: [UIPolyline] = []
    
    @State private var region = MKMapRect()
    
    @State private var searchingIdx = 0
    
    @State public var loadingResults: Bool = false
    @State public var showingResults: Bool = false
    
    @State private var routes: [UIRoutes] = []

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    map(geometry)
                        .frame(height: geometry.size.height / 2)
                    
                    VStack { // to fill the remaining space (will eventually hold favorites / last searches)
                        Text("")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                
                VStack { // purple background that sweeps up
                    Text("")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .background(UIColor.Theme.searchColor)
                .frame(width: geometry.size.width,
                       height: searching ? geometry.size.height + 75 : 0)
                .offset(CGSize(width: 0.0, height: -75))
                .opacity(searchingFastAnimated ? 1 : 0)
                
                VStack { // list background that sweeps up after
                    possibilitiesList()
                    .offset(CGSize(width: 0.0, height: 5))
                    .opacity(searchingSlowAnimated && !(loadingResults || showingResults) ? 1 : 0)
                    
                    ActivityIndicator(isAnimating: .constant(true), style: .large)
                    .offset(CGSize(width: 0.0, height: -geometry.size.height / 2))
                    .opacity(loadingResults ? 1 : 0)
                    
                    ScrollView(.horizontal) {
                        VStack {
                            timeMarks()
                            routesList()
                                .scrollClipDisabled()
                        }
                    }
                    .offset(CGSize(width: 0.0, height: -geometry.size.height / 2))
                    .opacity(showingResults ? 1 : 0)
                    
                }
                .background(UIColor.Theme.listBackgroundColor)
                .edgesIgnoringSafeArea(.all)
                .offset(CGSize(width: 0.0, height: searchingSlowAnimated ? 0 : geometry.size.height))
                .frame(height: geometry.size.height - 30)
                
                VStack {
                    searchBars()
                    Spacer()
                }
                .offset(CGSize(width: 10.0, height: searching ? 0 : geometry.size.height / 2 - 20))
            }
        }
    }
    
    func getDirections(senderID: Int) {
        withAnimation(Animation.easeInOut(duration: 0.5)) {
            loadingResults = true
        }
        
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
        
//        updatePolylines(withID: id1, newPolyline: emptyPolyline())
        
        APIHandler.shared.directions(origin: o, destination: d) { results, error in
            guard let route = results else {
                print("e", error)
                return
            }
            
            print("FOUND ROUTES", route.routes!.count)
            
//            print("GOT ROUTE", route)
            
//            let polyline = route.polyline.decode()
//            updatePolylines(withID: id1, newPolyline: polyline)
            updateRoutes(withID: id1, newRoute: route)
            
            withAnimation(Animation.easeInOut(duration: 0.5)) {
                loadingResults = false
                showingResults = true
            }
        }
    }
    
    func getWaypoint(_ id: Int) -> Waypoint? {
        var coord = annotations[id].location
        if coord == nil && id == 0 {
            coord = locationManager.lastLocation?.coordinate
        }
        return coord?.toWaypoint()
    }
    
    func updateRoutes(withID id: Int, newRoute: ComputeRoutesResponse) {
        let r = newRoute.routes!
        
        for i in routes.indices {
            if routes[i].id == id {
                routes[i].routes = r
                return
            }
        }
        routes.append(UIRoutes(id: id, routes: r))
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
    
    func map(_ geometry: GeometryProxy) -> some View {
        return Map {
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
    }
    
    func possibilitiesList() -> some View {
        return List(possibilities, selection: $selection) { place in
            HStack {
                Image(systemName: "mappin.and.ellipse")
                VStack(alignment: .leading) {
                    Text(place.main_text)
                        .font(.system(size: 17))
                        .lineLimit(1)
                    Text(place.secondary_text)
                        .font(.system(size: 10))
                        .lineLimit(1)
                }
            }
            .listRowBackground(UIColor.Theme.listBackgroundColor)
            .onTapGesture {
                addMarker(p: place)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
    }
    
    func timeMarks() -> some View {
        return HStack {
            ForEach(0..<6, id: \.self) { i in // todo calculate based on length of route
                Text(time(plus: i))
                    .offset(x: CGFloat(xposition(for: time(plus: i))))
            }
        }
    }
    
    func routesList() -> some View {
        return ForEach(routes) { rs in
//        let x: [Route] = []
//        if routes.count == 0 {
//            return             List(x) { route in
//                RouteView(route: route)
//                    .listRowBackground(UIColor.Theme.listBackgroundColor)
//            }
//            .listStyle(.plain)
//            .scrollContentBackground(.hidden)
//        }
//        return
            List(rs.routes) { route in
                RouteView(route: route)
                    .listRowBackground(UIColor.Theme.listBackgroundColor)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
    
    func addMarker(p: UIPlace) {
        APIHandler.shared.get_info(place_id: p.placeID) { data, error in
            guard let d = data else {
                print("i", error)
                return
            }

            let geom = d.result!.geometry!.location!
            let location = CLLocationCoordinate2D(latitude: geom.lat!,
                                                  longitude: geom.lng!)
            
            annotations[searchingIdx].name = d.result!.name!
            annotations[searchingIdx].location = location
            annotations[searchingIdx].placeID = p.placeID
            
            annotations[searchingIdx].justChanged = true
            
            getDirections(senderID: searchingIdx)
        }
    }
    
    func searchBars() -> some View {
        // todo expand or something
//        return ForEach($annotations) { $a in
//            TextDisplay(annotation: $a, 
//                        searching: $searching,
//                        searchingFastAnimated: $searchingFastAnimated,
//                        searchingSlowAnimated: $searchingSlowAnimated,
//                        possibilities: $possibilities,
//                        getDirections: getDirections)
//        }
        return HStack {
            TextDisplay(annotation: $annotations[1],
                        searching: $searching,
                        searchingFastAnimated: $searchingFastAnimated,
                        searchingSlowAnimated: $searchingSlowAnimated,
                        possibilities: $possibilities,
                        searchingIdx: $searchingIdx,
                        getDirections: getDirections)
        }
    }
}

#Preview {
    ContentView()
}

// https://stackoverflow.com/questions/56874133/use-hex-color-in-swiftui
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
