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

struct AutocompleteResult {
    public let description: String
    public let place_id: String
    // todo types? matches?
    
    init(json: [String: Any]) throws {
        description = json["description"] as! String
        place_id = json["place_id"] as! String
    }
}

struct AutocompleteResults {
    public let predictions: [AutocompleteResult]
    
    init(json: [String: Any]) throws {
        predictions = (json["predictions"] as! [[String: Any]]).map { place in
            return try! AutocompleteResult(json: place)
        }
    }
}

struct LocationResult {
    public let lat: String
    public let lng: String
    
    init(json: [String: Any]) throws {
        lat = json["lat"] as! String
        lng = json["lng"] as! String
    }
}

struct GeometryResult {
    public let location: LocationResult
    // todo viewport
    
    init(json: [String: Any]) throws {
        location = try! LocationResult(json: json["location"] as! [String: Any])
    }
}

struct DetailsResults {
    public let result: GeometryResult
    public let name: String
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
            let results = try! AutocompleteResults(json: places)
            
            handler(results, error)
        }
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
