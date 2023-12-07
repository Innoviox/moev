//
//  Utils.swift
//  moev
//
//  Created by Simon Chervenak on 12/6/23.
//

import Foundation
import CoreLocation
import MapKit

extension KeyedDecodingContainer {
    public func decodeIfPresent(_ type: [String: Any].Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [String: Any]? {
        guard let data = try? self.decode(Data.self, forKey: key) else {
            return nil
        }

        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
    }
    
    public func decodeIfPresent(_ type: [[String: Any]].Type, forKey key: KeyedDecodingContainer<K>.Key) throws -> [[String: Any]]? {
        guard let data = try? self.decode(Data.self, forKey: key) else {
            return nil
        }

        return try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
    }
}

extension KeyedEncodingContainer {
    public mutating func encodeIfPresent(_ value: [String: Any]?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let value = value else {
            return
        }

        let data = try JSONSerialization.data(withJSONObject: value, options: [])
        try self.encode(data, forKey: key)
    }
    
    public mutating func encodeIfPresent(_ value: [[String: Any]]?, forKey key: KeyedEncodingContainer<K>.Key) throws {
        guard let value = value else {
            return
        }

        let data = try JSONSerialization.data(withJSONObject: value, options: [])
        try self.encode(data, forKey: key)
    }
}

extension Polyline {
    func decode() -> MKPolyline {
        // https://developers.google.com/maps/documentation/utilities/polylinealgorithm
        var points: [CLLocationCoordinate2D] = []
        
        var point = ""
        var data: [Double] = []
        var last: [Double] = [0, 0]
                        
        for (i, char) in (encodedPolyline ?? "").enumerated() {
            point.append(char)
            if char.asciiValue! >= 95 && i != encodedPolyline!.count - 1 {
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

// https://developers.google.com/maps/documentation/places/web-service/autocomplete#PlaceAutocompletePrediction
enum PlacesAutocompleteStatus: String, Codable {
    case OK
    case ZERO_RESULTS
    case INVALID_REQUEST
    case OVER_QUERY_LIMIT
    case REQUEST_DENIED
    case UNKNOWN_ERROR
}

enum PlacesDetailsStatus: String, Codable {
    case OK
    case ZERO_RESULTS
    case INVALID_REQUEST
    case OVER_QUERY_LIMIT
    case REQUEST_DENIED
    case UNKNOWN_ERROR
}
