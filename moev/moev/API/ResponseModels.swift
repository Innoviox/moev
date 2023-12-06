////
////  ResponseModels.swift
////  moev
////
////  Created by Simon Chervenak on 12/5/23.
////
//
//import Foundation
//import CoreLocation
//import MapKit
//
//struct AutocompleteStructuredFormatting {
//    public let main_text: String?
//    public let secondary_text: String?
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        main_text = json["main_text"] as? String ?? ""
//        secondary_text = json["secondary_text"] as? String ?? ""
//    }
//}
//
//struct AutocompleteResult {
//    public let description: String?
//    public let place_id: String?
//    public let structured_formatting: AutocompleteStructuredFormatting?
//    // todo types? matches?
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        description = json["description"] as? String ?? ""
//        place_id = json["place_id"] as? String ?? ""
//        structured_formatting = AutocompleteStructuredFormatting(json: json["structured_formatting"] as! [String: Any])
//    }
//}
//
//struct AutocompleteResults {
//    public let predictions: [AutocompleteResult]
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        predictions = (json["predictions"] as! [[String: Any]]).map { place in
//            return AutocompleteResult(json: place)
//        }
//    }
//}
//
//struct LocationResult {
//    public let lat: Double?
//    public let lng: Double?
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        lat = Double(truncating: json["lat"] as? NSNumber)
//        lng = Double(truncating: json["lng"] as? NSNumber)
//    }
//}
//
//struct GeometryResult {
//    public let location: LocationResult?
//    // todo viewport
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        location = LocationResult(json: json["location"] as? [String: Any])
//    }
//}
//
//struct Result {
//    public let geometry: GeometryResult
//    public let name: String
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        geometry = GeometryResult(json: json["geometry"] as! [String: Any])
//        name = json["name"] as! String
//    }
//}
//
//struct DetailsResults {
//    public let result: Result
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        result = Result(json: json["result"] as! [String: Any])
//        // todo html attributions?
//    }
//}
//
//enum Maneuver: String {
//    case MANEUVER_UNSPECIFIED
//    case TURN_SLIGHT_LEFT
//    case TURN_SHARP_LEFT
//    case UTURN_LEFT
//    case TURN_LEFT
//    case TURN_SLIGHT_RIGHT
//    case TURN_SHARP_RIGHT
//    case UTURN_RIGHT
//    case TURN_RIGHT
//    case STRAIGHT
//    case RAMP_LEFT
//    case RAMP_RIGHT
//    case MERGE
//    case FORK_LEFT
//    case FORK_RIGHT
//    case FERRY
//    case FERRY_TRAIN
//    case ROUNDABOUT_LEFT
//    case ROUNDABOUT_RIGHT
//    case DEPART
//    case NAME_CHANGE
//}
//
//struct NavigationInstruction {
//    let maneuver: Maneuver
//    let instructions: String
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        maneuver = Maneuver(rawValue: json["maneuver"] as! String)!
//        instructions = json["instructions"] as! String
//    }
//}
//
//struct RouteLegStep {
//    let distanceMeters: Int
//    let staticDuration: String
//    let polyline: Polyline
//    let startLocation: Location
//    let endLocation: Location
//    let navigationInstruction: NavigationInstruction
//    let travelAdvisory: RouteLegStepTravelAdvisory
//    let transitDetails: RouteLegStepTransitDetails
//    let travelMode: RouteTravelMode
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        distanceMeters = json["distanceMeters"] as? Int ?? 0
//        staticDuration = json["staticDuration"] as? String ?? "0s"
//        polyline = Polyline(json: json["polyline"] as! [String: Any])
//        startLocation = Location(json: json["startLocation"] as! [String: Any])
//        endLocation = Location(json: json["endLocation"] as! [String: Any])
//        navigationInstruction = NavigationInstruction(json: json["navigationInstruction"] as! [String: Any])
//        travelAdvisory = RouteLegStepTravelAdvisory(json: json["travelAdvisory"] as! [String: Any])
//        transitDetails = RouteLegStepTransitDetails(json: json["transitDetails"] as! [String: Any])
//        travelMode = RouteTravelMode(json: json["travelMode"] as! [String: Any])
//    }
//}
//
//struct RouteLeg: Encodable {
//    let distanceMeters: Int
//    let duration: String
//    let staticDuration: String
//    let polyline: Polyline
//    let startLocation: Location
//    let endLocation: Location
//    let steps: [RouteLegStep]?
//    let travelAdvisory: RouteLegTravelAdvisory
//    let localizedValues: RouteLegLocalizedValues
//    let stepsOverview: StepsOverview
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        distanceMeters = json["distanceMeters"] as? Int ?? 0
//        duration = json["duration"] as? String ?? "0s"
//        polyline = Polyline(json: json["polyline"] as! [String: Any])
//        startLocation = Location(json: json["startLocation"] as! [String: Any])
//        endLocation = Location(json: json["endLocation"] as! [String: Any])
//        steps = (json["steps"] as? [[String: Any]] ?? nil)?.map { j in RouteLegStep(json: j) }
//        travelAdvisory = RouteLegTravelAdvisory(json: json["travelAdvisory"] as! [String: Any])
//        stepsOverview = StepsOverview(json: json["stepsOverview"] as! [String: Any])
//    }
//}
//
//struct RouteTravelAdvisory {
//    
//}
//
//struct Viewport {
//    public let high: LatitudeLongitude?
//    public let low: LatitudeLongitude?
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        high = LatitudeLongitude(json: json["high"] as? [String: Any])
//        low = LatitudeLongitude(json: json["low"] as? [String: Any])
//    }
//}
//
//struct Polyline {
//    public let encodedPolyline: String?
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        encodedPolyline = json["encodedPolyline"] as? String
//    }
//    
//    func decode() -> MKPolyline {
//        // https://developers.google.com/maps/documentation/utilities/polylinealgorithm
//        var points: [CLLocationCoordinate2D] = []
//        
//        var point = ""
//        var data: [Double] = []
//        var last: [Double] = [0, 0]
//                        
//        for (i, char) in (encodedPolyline ?? "").enumerated() {
//            point.append(char)
//            if char.asciiValue! >= 95 && i != encodedPolyline!.count - 1 {
//                continue
//            }
//            
//            let val = point.map { c in
//                var v = c.asciiValue! - 63 // remove ASCII-fication
//                if v >= 32 { // remove continuation bit
//                    v -= 32
//                }
//                
//                var s = String(v, radix: 2)
//                s = String(repeating: "0", count: 5 - s.count) + s // pad to chunks of 5
//                return s
//            }.reversed().joined() // reverse chunk order
//            
//            var i = Int("0" + val.dropLast(), radix: 2)! // right shift
//            if val.last! == "1" { // 2s complement
//                i = -i - 1
//            }
//            
//            data.append(Double(i) / 100000.0) // convert back to coordinate range
//            
//            if data.count == 2 {
//                last = [last[0] + data[0], last[1] + data[1]]
//                
//                let coord = CLLocationCoordinate2D(latitude: last[0], longitude: last[1])
//                points.append(coord)
//                data = []
//            }
//            
//            point = ""
//        }
//        
//        return MKPolyline(coordinates: points, count: points.count)
//    }
//}
//
//enum RouteLabel: String {
//    case ROUTE_LABEL_UNSPECIFIED
//    case DEFAULT_ROUTE
//    case DEFAULT_ROUTE_ALTERNATE
//    case FUEL_EFFICIENT
//}
//
//struct Route {
//    public let routeLabels: [RouteLabel]?
//    public let legs: [RouteLeg]?
//    public let distanceMeters: Int?
//    public let duration: String?
//    public let staticDuration: String?
//    public let polyline: Polyline?
//    public let description: String?
//    public let warnings: [String]?
//    public let viewport: Viewport?
//    public let travelAdvisory: RouteTravelAdvisory?
//    public let optimizedIntermediateWaypointIndex: Int?
//    public let localizedValues: RouteLocalizedValues?
//    public let routeToken: String?
//    
//    init(json jsonOrNil: [String: Any]?) {
//        guard let json = jsonOrNil else {
//            return
//        }
//        
//        duration = json["duration"] as? String
//        distanceMeters = json["distanceMeters"] as? Int
//        
//        polyline = Polyline(json: json["polyline"] as? [String: Any])
//        legs = (json["legs"] as? [[String: Any]] ?? []).map { j in RouteLeg(json: j) }
//        travelAdvisory = RouteTravelAdvisory(json["routeTravelAdvisory"] as? [String: Any])
//        viewport = Viewport(json: json["viewport"] as? [String: Any])
//    }
//}
//
//struct FallbackInfo {
//    
//}
//
//struct GeocodingResults {
//    
//}
//
