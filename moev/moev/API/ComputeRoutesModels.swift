//
//  ComputeRoutesModels.swift
//  moev
//
//  Created by Simon Chervenak on 12/6/23.
//

import Foundation

struct FallbackInfo {
    let routingMode: FallbackRoutingMode? // Routing mode used for the response. If fallback was triggered, the mode may be different from routing preference set in the original client request.
    let reason: FallbackReason? // The reason why fallback response was used instead of the original response. This field is only populated when the fallback mode is triggered and the fallback response is returned.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jroutingMode = json["routingMode"] as? String {
            routingMode = FallbackRoutingMode(rawValue: jroutingMode)!
        }

        if let jreason = json["reason"] as? String {
            reason = FallbackReason(rawValue: jreason)!
        }

    }
}


struct LatLng {
    let latitude: number? // The latitude in degrees. It must be in the range [-90.0, +90.0].
    let longitude: number? // The longitude in degrees. It must be in the range [-180.0, +180.0].

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jlatitude = json["latitude"] as? number {
            latitude = jlatitude
        }

        if let jlongitude = json["longitude"] as? number {
            longitude = jlongitude
        }

    }
}


struct LocalizedText {
    let text: String? // Localized string in the language corresponding to languageCode below.
    let languageCode: String? // The text's BCP-47 language code, such as "en-US" or "sr-Latn".

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jtext = json["text"] as? String {
            text = jtext
        }

        if let jlanguageCode = json["languageCode"] as? String {
            languageCode = jlanguageCode
        }

    }
}


struct Location {
    let latLng: LatLng? // The waypoint's geographic coordinates.
    let heading: Int? // The compass heading associated with the direction of the flow of traffic. This value specifies the side of the road for pickup and drop-off. Heading values can be from 0 to 360, where 0 specifies a heading of due North, 90 specifies a heading of due East, and so on. You can use this field only for DRIVE and TWO_WHEELER RouteTravelMode.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jlatLng = json["latLng"] as? [String: Any] {
            latLng = LatLng(json: jlatLng)
        }

        if let jheading = json["heading"] as? Int {
            heading = jheading
        }

    }
}


struct Money {
    let currencyCode: String? // The three-letter currency code defined in ISO 4217.
    let units: String? // The whole units of the amount. For example if currencyCode is "USD", then 1 unit is one US dollar.
    let nanos: Int? // Number of nano (10^-9) units of the amount. The value must be between -999,999,999 and +999,999,999 inclusive. If units is positive, nanos must be positive or zero. If units is zero, nanos can be positive, zero, or negative. If units is negative, nanos must be negative or zero. For example $-1.75 is represented as units=-1 and nanos=-750,000,000.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jcurrencyCode = json["currencyCode"] as? String {
            currencyCode = jcurrencyCode
        }

        if let junits = json["units"] as? String {
            units = junits
        }

        if let jnanos = json["nanos"] as? Int {
            nanos = jnanos
        }

    }
}


struct RouteModifiers {
    let avoidTolls: Bool? // When set to true, avoids toll roads where reasonable, giving preference to routes not containing toll roads. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
    let avoidHighways: Bool? // When set to true, avoids highways where reasonable, giving preference to routes not containing highways. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
    let avoidFerries: Bool? // When set to true, avoids ferries where reasonable, giving preference to routes not containing ferries. Applies only to the DRIVE andTWO_WHEELER RouteTravelMode.
    let avoidIndoor: Bool? // When set to true, avoids navigating indoors where reasonable, giving preference to routes not containing indoor navigation. Applies only to the WALK RouteTravelMode.
    let vehicleInfo: VehicleInfo? // Specifies the vehicle information.
    let tollPasses: [TollPass]? // Encapsulates information about toll passes. If toll passes are provided, the API tries to return the pass price. If toll passes are not provided, the API treats the toll pass as unknown and tries to return the cash price. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let javoidTolls = json["avoidTolls"] as? Bool {
            avoidTolls = javoidTolls
        }

        if let javoidHighways = json["avoidHighways"] as? Bool {
            avoidHighways = javoidHighways
        }

        if let javoidFerries = json["avoidFerries"] as? Bool {
            avoidFerries = javoidFerries
        }

        if let javoidIndoor = json["avoidIndoor"] as? Bool {
            avoidIndoor = javoidIndoor
        }

        if let jvehicleInfo = json["vehicleInfo"] as? [String: Any] {
            vehicleInfo = VehicleInfo(json: jvehicleInfo)
        }

        tollPasses = (json["tollPasses"] as? [String] ?? nil)?.map { j in TollPass(rawValue: j as! String)! }
        

    }
}


struct RouteTravelAdvisory {
    let tollInfo: TollInfo? // Contains information about tolls on the route. This field is only populated if tolls are expected on the route. If this field is set, but the estimatedPrice subfield is not populated, then the route contains tolls, but the estimated price is unknown. If this field is not set, then there are no tolls expected on the route.
    let speedReadingIntervals: [SpeedReadingInterval]? // Speed reading intervals detailing traffic density. Applicable in case of TRAFFIC_AWARE and TRAFFIC_AWARE_OPTIMAL routing preferences. The intervals cover the entire polyline of the route without overlap. The start point of a specified interval is the same as the end point of the preceding interval.
    let fuelConsumptionMicroliters: String? // The predicted fuel consumption in microliters.
    let routeRestrictionsPartiallyIgnored: Bool? // Returned route may have restrictions that are not suitable for requested travel mode or route modifiers.
    let transitFare: Money? // If present, contains the total fare or ticket costs on this route This property is only returned for TRANSIT requests and only for routes where fare information is available for all transit steps.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jtollInfo = json["tollInfo"] as? [String: Any] {
            tollInfo = TollInfo(json: jtollInfo)
        }

        speedReadingIntervals = (json["speedReadingIntervals"] as? [[String: Any]] ?? nil)?.map { j in SpeedReadingInterval(json: j) }
        

        if let jfuelConsumptionMicroliters = json["fuelConsumptionMicroliters"] as? String {
            fuelConsumptionMicroliters = jfuelConsumptionMicroliters
        }

        if let jrouteRestrictionsPartiallyIgnored = json["routeRestrictionsPartiallyIgnored"] as? Bool {
            routeRestrictionsPartiallyIgnored = jrouteRestrictionsPartiallyIgnored
        }

        if let jtransitFare = json["transitFare"] as? [String: Any] {
            transitFare = Money(json: jtransitFare)
        }

    }
}


enum RouteTravelMode: String {
    case TRAVEL_MODE_UNSPECIFIED // No travel mode specified. Defaults to DRIVE.
    case DRIVE // Travel by passenger car.
    case BICYCLE // Travel by bicycle.
    case WALK // Travel by walking.
    case TWO_WHEELER // Two-wheeled, motorized vehicle. For example, motorcycle. Note that this differs from the BICYCLE travel mode which covers human-powered mode.
    case TRANSIT // Travel by public transit routes, where available.
}


enum RoutingPreference: String {
    case ROUTING_PREFERENCE_UNSPECIFIED // No routing preference specified. Default to TRAFFIC_UNAWARE.
    case TRAFFIC_UNAWARE // Computes routes without taking live traffic conditions into consideration. Suitable when traffic conditions don't matter or are not applicable. Using this value produces the lowest latency. Note: For RouteTravelMode DRIVE and TWO_WHEELER, the route and duration chosen are based on road network and average time-independent traffic conditions, not current road conditions. Consequently, routes may include roads that are temporarily closed. Results for a given request may vary over time due to changes in the road network, updated average traffic conditions, and the distributed nature of the service. Results may also vary between nearly-equivalent routes at any time or frequency.
    case TRAFFIC_AWARE // Calculates routes taking live traffic conditions into consideration. In contrast to TRAFFIC_AWARE_OPTIMAL, some optimizations are applied to significantly reduce latency.
    case TRAFFIC_AWARE_OPTIMAL // Calculates the routes taking live traffic conditions into consideration, without applying most performance optimizations. Using this value produces the highest latency.
}


struct SpeedReadingInterval {
    let startPolylinePointIndex: Int? // The starting index of this interval in the polyline.
    let endPolylinePointIndex: Int? // The ending index of this interval in the polyline.
    let speed: Speed? // Traffic speed in this interval.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jstartPolylinePointIndex = json["startPolylinePointIndex"] as? Int {
            startPolylinePointIndex = jstartPolylinePointIndex
        }

        if let jendPolylinePointIndex = json["endPolylinePointIndex"] as? Int {
            endPolylinePointIndex = jendPolylinePointIndex
        }

        if let jspeed = json["speed"] as? String {
            speed = Speed(rawValue: jspeed)!
        }

    }
}


struct Status {
    let code: Int? // The status code, which should be an enum value of google.rpc.Code.
    let message: String? // A developer-facing error message, which should be in English. Any user-facing error message should be localized and sent in the google.rpc.Status.details field, or localized by the client.
    let details: [object]? // A list of messages that carry the error details. There is a common set of message types for APIs to use.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jcode = json["code"] as? Int {
            code = jcode
        }

        if let jmessage = json["message"] as? String {
            message = jmessage
        }

        details = (json["details"] as? [[String: Any]] ?? nil)?.map { j in object(json: j) }
        

    }
}


struct TollInfo {
    let estimatedPrice: [Money]? // The monetary amount of tolls for the corresponding Route or RouteLeg. This list contains a money amount for each currency that is expected to be charged by the toll stations. Typically this list will contain only one item for routes with tolls in one currency. For international trips, this list may contain multiple items to reflect tolls in different currencies.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            estimatedPrice = (json["estimatedPrice"] as? [[String: Any]] ?? nil)?.map { j in Money(json: j) }
        

    }
}


enum TrafficModel: String {
    case TRAFFIC_MODEL_UNSPECIFIED // Unused. If specified, will default to BEST_GUESS.
    case BEST_GUESS // Indicates that the returned duration should be the best estimate of travel time given what is known about both historical traffic conditions and live traffic. Live traffic becomes more important the closer the departureTime is to now.
    case PESSIMISTIC // Indicates that the returned duration should be longer than the actual travel time on most days, though occasional days with particularly bad traffic conditions may exceed this value.
    case OPTIMISTIC // Indicates that the returned duration should be shorter than the actual travel time on most days, though occasional days with particularly good traffic conditions may be faster than this value.
}


struct TransitPreferences {
    let allowedTravelModes: [TransitTravelMode]? // A set of travel modes to use when getting a TRANSIT route. Defaults to all supported modes of travel.
    let routingPreference: TransitRoutingPreference? // A routing preference that, when specified, influences the TRANSIT route returned.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            allowedTravelModes = (json["allowedTravelModes"] as? [String] ?? nil)?.map { j in TransitTravelMode(rawValue: j as! String)! }
        

        if let jroutingPreference = json["routingPreference"] as? String {
            routingPreference = TransitRoutingPreference(rawValue: jroutingPreference)!
        }

    }
}


struct Waypoint {
    let via: Bool? // Marks this waypoint as a milestone rather a stopping point. For each non-via waypoint in the request, the response appends an entry to the legs array to provide the details for stopovers on that leg of the trip. Set this value to true when you want the route to pass through this waypoint without stopping over. Via waypoints don't cause an entry to be added to the legs array, but they do route the journey through the waypoint. You can only set this value on waypoints that are intermediates. The request fails if you set this field on terminal waypoints. If ComputeRoutesRequest.optimize_waypoint_order is set to true then this field cannot be set to true; otherwise, the request fails.
    let vehicleStopover: Bool? // Indicates that the waypoint is meant for vehicles to stop at, where the intention is to either pickup or drop-off. When you set this value, the calculated route won't include non-via waypoints on roads that are unsuitable for pickup and drop-off. This option works only for DRIVE and TWO_WHEELER travel modes, and when the locationType is Location.
    let sideOfRoad: Bool? // Indicates that the location of this waypoint is meant to have a preference for the vehicle to stop at a particular side of road. When you set this value, the route will pass through the location so that the vehicle can stop at the side of road that the location is biased towards from the center of the road. This option works only for 'DRIVE' and 'TWO_WHEELER' RouteTravelMode.
    let location: Location? // A point specified using geographic coordinates, including an optional heading.
    let placeId: String? // The POI Place ID associated with the waypoint.
    let address: String? // Human readable address or a plus code. See https://plus.codes for details.

        init(json jsonOrNil: [String: Any]?) {
            guard let json = jsonOrNil else {
                return
            }
    
            if let jvia = json["via"] as? Bool {
            via = jvia
        }

        if let jvehicleStopover = json["vehicleStopover"] as? Bool {
            vehicleStopover = jvehicleStopover
        }

        if let jsideOfRoad = json["sideOfRoad"] as? Bool {
            sideOfRoad = jsideOfRoad
        }

        if let jlocation = json["location"] as? [String: Any] {
            location = Location(json: jlocation)
        }

        if let jplaceId = json["placeId"] as? String {
            placeId = jplaceId
        }

        if let jaddress = json["address"] as? String {
            address = jaddress
        }

    }
}


