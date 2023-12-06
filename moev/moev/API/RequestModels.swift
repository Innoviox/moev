//
//  RequestModels.swift
//  moev
//
//  Created by Simon Chervenak on 12/5/23.
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

struct Location {
    let latLng: LatitudeLongitude
    let heading: Int
    
    init(json: [String: Any]) {
        latLng = LatitudeLongitude(json: json["latLng"] as! [String: Any])
        heading = json["heading"] as? Int ?? 0
    }
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
