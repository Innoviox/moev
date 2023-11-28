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

typealias RequestHandler = (Data?, URLResponse?, Error?) -> Void

class APIHandler {
    static let shared = APIHandler()
    
    let GMAK: String
    
    init() {
        GMAK = Bundle.main.infoDictionary!["GOOGLE_MAPS_API_KEY"] as! String
    }
    
    func _request(url: String, headers: [String: String], body: Encodable, method: String, handler: @escaping RequestHandler) {
        do {
            let url = URL(string: url)!
            var request = URLRequest(url: url)
            for (header, value) in headers {
                request.setValue(value, forHTTPHeaderField: header)
            }
            request.httpMethod = method
            let encoder = JSONEncoder()
            let data = try encoder.encode(body)
            request.httpBody = data

            let task = URLSession.shared.dataTask(with: request, completionHandler: handler)
        } catch {
            
        }
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
        let url = "https://maps.googleapis.com/maps/api/directions/json?mode=transit&origin=place_id:\(origin)&destination=place_id:\(destination)"
        
        _request(url: url, headers: headers, body: body, method: "GET", handler: handler)
    }
}
