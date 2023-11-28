//
//  APIHandler.swift
//  moev
//
//  Created by Simon Chervenak on 11/27/23.
//

import Foundation
import CoreLocation

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
    
    func nearbyPlaces(center: CLLocationCoordinate2D, radius: Int = 100, url: String = "https://places.googleapis.com/v1/places:searchNearby", handler: @escaping RequestHandler) {
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
    
    func directions(origin: String, destination: String, handler: @escaping RequestHandler) {
        _get_request(baseurl: "https://maps.googleapis.com/maps/api/directions/json?", params: [
            "mode": "transit",
            "origin": "place_id:\(origin)",
            "destination": "place_id:\(destination)",
            "key": GMAK
        ], handler: handler)
    }
    
    func start_session() {
        session = UUID()
    }
    
    func autocomplete(query: String, handler: @escaping RequestHandler) {
        if session == nil {
            start_session()
        }
        
        _get_request(baseurl: "https://maps.googleapis.com/maps/api/place/autocomplete/json?", params: [
            "input": query,
            "sessiontoken": session!.uuidString,
            "key": GMAK
        ], handler: handler)
    }
    
    func get_info(place_id: String, handler: @escaping RequestHandler) {
        _get_request(baseurl: "https://maps.googleapis.com/maps/api/place/details/json?", params: [
            "place_id": place_id,
            "fields": "geometry,name",
            "sessiontoken": session!.uuidString,
            "key": GMAK
        ]) { [self] (d, u, e) in
            session = nil
            handler(d, u, e)
        }
    }
}
