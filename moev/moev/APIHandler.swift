//
//  APIHandler.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import Foundation
import CoreLocation
import MapKit

struct Circle: Encodable {
    let center: [String: CLLocationDegrees]
    let radius: Int
}

struct LocationRestriction: Encodable {
    let circle: Circle
}

struct NearbyPlacesBody: Encodable {
    let maxResultCount: Int
    let rankPreference: String
    let locationRestriction: LocationRestriction
}

struct Empty: Encodable {}

struct AutocompleteResult {
    public let description: String
    public let place_id: String
    // todo types? matches?
    
    init(json: [String: Any]) {
        description = json["description"] as! String
        place_id = json["place_id"] as! String
    }
}

struct AutocompleteResults {
    public let predictions: [AutocompleteResult]
    
    init(json: [String: Any]) {
        predictions = (json["predictions"] as! [[String: Any]]).map { place in
            return AutocompleteResult(json: place)
        }
    }
}

struct LocationResult {
    public let lat: Double
    public let lng: Double
    
    init(json: [String: Any]) {
        lat = Double(truncating: json["lat"] as! NSNumber)
        lng = Double(truncating: json["lng"] as! NSNumber)
    }
}

struct GeometryResult {
    public let location: LocationResult
    // todo viewport
    
    init(json: [String: Any]) {
        location = LocationResult(json: json["location"] as! [String: Any])
    }
}

struct Result {
    public let geometry: GeometryResult
    public let name: String
    
    init(json: [String: Any]) {
        geometry = GeometryResult(json: json["geometry"] as! [String: Any])
        name = json["name"] as! String
    }
}

struct DetailsResults {
    public let result: Result
    
    init(json: [String: Any]) {
        result = Result(json: json["result"] as! [String: Any])
        // todo html attributions?
    }
}

struct LatitudeLongitude: Encodable {
    public let latitude: Double
    public let longitude: Double
    
    init(json: [String: Any]) {
        latitude = Double(truncating: json["latitude"] as! NSNumber)
        longitude = Double(truncating: json["longitude"] as! NSNumber)
    }
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

struct LatLng: Encodable {
    let latLng: LatitudeLongitude
}

struct Waypoint: Encodable {
    let location: LatLng
}

struct RoutesBody: Encodable {
    let origin: Waypoint
    let destination: Waypoint
    let travelMode: String
    let languageCode: String = "en-US"
}

struct RouteLeg {
    
}

struct RouteTravelAdvisory {
    
}

struct Viewport {
    public let high: LatitudeLongitude
    public let low: LatitudeLongitude
    
    init(json: [String: Any]) {
        high = LatitudeLongitude(json: json["high"] as! [String: Any])
        low = LatitudeLongitude(json: json["low"] as! [String: Any])
    }
}

struct Polyline {
    public let encodedPolyline: String
    
    init(json: [String: Any]) {
        encodedPolyline = json["encodedPolyline"] as! String
    }
    
    func decode() -> MKPolyline {
        // https://developers.google.com/maps/documentation/utilities/polylinealgorithm
        var points: [CLLocationCoordinate2D] = []
        
        var point = ""
        var data: [Double] = []
        var last: [Double] = [0, 0]
                        
        for (i, char) in encodedPolyline.enumerated() {
            point.append(char)
            if char.asciiValue! >= 95 && i != encodedPolyline.count - 1 {
                continue
            }
            
            let val = point.map { c in
                var v = c.asciiValue! - 63 // remove ASCII-fication
                if v >= 32 { // remove continuation bit
                    v -= 32
                }
                
                var s = String(v, radix: 2)
                s = String(repeating: "0", count: 5 - s.count) + s // pad to chunks of 5
                return s
            }.reversed().joined() // reverse chunk order
            
            var i = Int("0" + val.dropLast(), radix: 2)! // right shift
            if val.last! == "1" { // 2s complement
                i = -i - 1
            }
            
            data.append(Double(i) / 100000.0) // convert back to coordinate range
            
            if data.count == 2 {
                last = [last[0] + data[0], last[1] + data[1]]
                
                let coord = CLLocationCoordinate2D(latitude: last[0], longitude: last[1])
                points.append(coord)
                data = []
            }
            
            point = ""
        }
        
        return MKPolyline(coordinates: points, count: points.count)
    }
}

struct DirectionsResults {
    public let duration: String
    public let distanceMeters: Int
    public let polyline: Polyline
    // todo
//    public let legs: [RouteLeg]
//    public let travelAdvisory: RouteTravelAdvisory
    public let viewport: Viewport
    
    init(json: [String: Any]) {
        duration = json["duration"] as! String
        distanceMeters = json["distanceMeters"] as! Int
        polyline = Polyline(json: json["polyline"] as! [String: Any])
//        legs = (json["legs"] as! [[String: Any]]).map { j in RouteLeg(j) }
//        travelAdvisory = RouteTravelAdvisory(json["routeTravelAdvisory"] as! [String: Any])
        viewport = Viewport(json: json["viewport"] as! [String: Any])
    }
}

typealias RequestHandler = (Data?, URLResponse?, Error?) -> Void

class APIHandler {
    static let shared = APIHandler()
    
    let GMAK: String
    
    var session: UUID? = nil
    
    init() {
        GMAK = Bundle.main.infoDictionary!["GOOGLE_MAPS_API_KEY"] as! String
    }
    
    func _request(url: String, headers: [String: String], body: Encodable?, method: String, handler: @escaping RequestHandler) {
        do {
            let url = URL(string: url)!
            var request = URLRequest(url: url)
            for (header, value) in headers {
                request.setValue(value, forHTTPHeaderField: header)
            }
            request.httpMethod = method
            let encoder = JSONEncoder()
            
            if let b = body {
                let data = try encoder.encode(b)
                request.httpBody = data
            }

            let task = URLSession.shared.dataTask(with: request, completionHandler: handler)
            task.resume()
        } catch {
            
        }
    }
    
    func _get_request(baseurl: String, params: [String: String], handler: @escaping RequestHandler) {
        var first = true
        var url = baseurl
        for (key, value) in params {
            if (!first) {
                url += "&"
            } else {
                first = false
            }
            
            url += "\(key)=\(value)"
        }
        
        print("GET REQUESTING", url)
        
        _request(url: url, headers: [:], body: nil, method: "GET", handler: handler)
    }
    
    func nearbyPlaces(center: CLLocationCoordinate2D, radius: Int = 100, handler: @escaping RequestHandler) {
        let url = "https://places.googleapis.com/v1/places:searchNearby"
        let body = NearbyPlacesBody(
            maxResultCount: 10,
            rankPreference: "DISTANCE",
            locationRestriction: LocationRestriction(
                circle: Circle(center: [
                    "latitude": center.latitude,
                    "longitude": center.longitude
                ],
                radius: radius)
            )
        )

        let headers: [String: String] = [
            "X-Goog-Api-Key": GMAK,
            "X-Goog-FieldMask": "places.displayName,places.photos"
        ]
        
        _request(url: url, headers: headers, body: body, method: "POST", handler: handler)
    }
    
    func directions(origin: Waypoint, destination: Waypoint, handler: @escaping(DirectionsResults?, Error?) -> Void) {
        let url = "https://routes.googleapis.com/directions/v2:computeRoutes"
        
        let body = RoutesBody(origin: origin, destination: destination, travelMode: "TRANSIT")
        
        let fields = [
            "routes.duration",
            "routes.distanceMeters",
            "routes.polyline.encodedPolyline",
            // todo this mess
//            "routes.legs",
//            "routes.travelAdvisory",
            "routes.viewport"
        ]
        
        let headers: [String: String] = [
            "Content-Type": "application/json",
            "X-Goog-Api-Key": GMAK,
            "X-Goog-FieldMask": fields.joined(separator: ",")
        ]
        
        _request(url: url, headers: headers, body: body, method: "POST") { data, response, error in
            guard let d = data else {
                return handler(nil, error)
            }
            
            let route = try! JSONSerialization.jsonObject(with: d, options: []) as! [String : Any]
            let results = DirectionsResults(json: (route["routes"] as! [[String: Any]])[0])
            handler(results, error)
//            let results = AutocompleteResults(json: places)
//            
//            handler(results, error)
        }
    }
    
    func start_session() {
        session = UUID()
    }
    
    func autocomplete(query: String, handler: @escaping (AutocompleteResults?, Error?) -> Void) {
        if session == nil {
            start_session()
        }
        
        _get_request(baseurl: "https://maps.googleapis.com/maps/api/place/autocomplete/json?", params: [
            "input": query,
            "sessiontoken": session!.uuidString,
            "key": GMAK
        ]) { data, response, error in
            guard let d = data else {
                return handler(nil, error)
            }
            
            let places = try! JSONSerialization.jsonObject(with: d, options: []) as! [String : Any]
            let results = AutocompleteResults(json: places)
            
            handler(results, error)
        }
    }
    
    func get_info(place_id: String, handler: @escaping (DetailsResults?, Error?) -> Void) {
        _get_request(baseurl: "https://maps.googleapis.com/maps/api/place/details/json?", params: [
            "place_id": place_id,
            "fields": "geometry,name",
            "sessiontoken": session!.uuidString,
            "key": GMAK
        ]) { [self] (d, u, e) in
            session = nil

            guard let j = d else {
                return handler(nil, e)
            }
            
            let data = try! JSONSerialization.jsonObject(with: j, options: []) as! [String : Any]
            let results = DetailsResults(json: data)
            
            handler(results, e)
        }
    }
}

extension CLLocationCoordinate2D {
    func toWaypoint() -> Waypoint {
        return Waypoint(
            location: LatLng(
                latLng: LatitudeLongitude(
                    latitude: latitude,
                    longitude: longitude
                )
            )
        )
    }
}
