//
//  APIHandler.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import Foundation
import CoreLocation
import MapKit

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
        
//        print("GET REQUESTING", url)
        
        _request(url: url, headers: [:], body: nil, method: "GET", handler: handler)
    }
    
//    func nearbyPlaces(center: CLLocationCoordinate2D, radius: Int = 100, handler: @escaping RequestHandler) {
//        let url = "https://places.googleapis.com/v1/places:searchNearby"
//        let body = NearbyPlacesBody(
//            maxResultCount: 10,
//            rankPreference: "DISTANCE",
//            locationRestriction: LocationRestriction(
//                circle: Circle(center: [
//                    "latitude": center.latitude,
//                    "longitude": center.longitude
//                ],
//                radius: radius)
//            )
//        )
//
//        let headers: [String: String] = [
//            "X-Goog-Api-Key": GMAK,
//            "X-Goog-FieldMask": "places.displayName,places.photos"
//        ]
//        
//        _request(url: url, headers: headers, body: body, method: "POST", handler: handler)
//    }
    
    func directions(origin: Waypoint, destination: Waypoint, handler: @escaping(ComputeRoutesResponse?, Error?) -> Void) {
        let url = "https://routes.googleapis.com/directions/v2:computeRoutes"
        
        let body = ComputeRoutesRequest(
            origin: origin,
            destination: destination,
            travelMode: .TRANSIT,
            polylineEncoding: .ENCODED_POLYLINE,
            computeAlternativeRoutes: false // true
        )
        
        let fields = [
            "routes.duration",
            "routes.distanceMeters",
            "routes.polyline.encodedPolyline",
            "routes.description",
            "routes.legs",
            "routes.travelAdvisory",
            "routes.viewport",
            "routes.localizedValues"
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
            
            let results = ComputeRoutesResponse.from(jsonData: d)
            
            handler(results, error)
        }
    }
    
    func start_session() {
        session = UUID()
    }
    
    func autocomplete(query: String, handler: @escaping (PlacesAutocompleteResponse?, Error?) -> Void) {
        if session == nil {
            start_session()
        }
        
        _get_request(baseurl: "https://maps.googleapis.com/maps/api/place/autocomplete/json?", params: [
            "input": query,
            "sessiontoken": session!.uuidString,
            "key": GMAK
        ]) { data, response, error in
            guard let d = data else {
                print("e", error)
                return handler(nil, error)
            }
            
            
            let results = PlacesAutocompleteResponse.from(jsonData: d)
                        
            handler(results, error)
        }
    }
    
    func get_info(place_id: String, handler: @escaping (PlacesDetailsResponse?, Error?) -> Void) {
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
            
            let results = PlacesDetailsResponse.from(jsonData: j)
            
            handler(results, e)
        }
    }
}
