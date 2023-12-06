//
//  ComputeRoutesModels.swift
//  moev
//
//  Created by Simon Chervenak on 12/6/23.
//

import Foundation






enum PolylineQuality: String {
    case POLYLINE_QUALITY_UNSPECIFIED // No polyline quality preference specified. Defaults to OVERVIEW.
    case HIGH_QUALITY // Specifies a high-quality polyline - which is composed using more points than OVERVIEW, at the cost of increased response size. Use this value when you need more precision.
    case OVERVIEW // Specifies an overview polyline - which is composed using a small number of points. Use this value when displaying an overview of the route. Using this option has a lower request latency compared to using the HIGH_QUALITY option.
}

enum PolylineEncoding: String {
    case POLYLINE_ENCODING_UNSPECIFIED // No polyline type preference specified. Defaults to ENCODED_POLYLINE.
    case ENCODED_POLYLINE // Specifies a polyline encoded using the polyline encoding algorithm.
    case GEO_JSON_LINESTRING // Specifies a polyline using the GeoJSON LineString format
}

enum Units: String {
    case UNITS_UNSPECIFIED // Units of measure not specified. Defaults to the unit of measure inferred from the request.
    case METRIC // Metric units of measure.
    case IMPERIAL // Imperial (English) units of measure.
}

enum ReferenceRoute: String {
    case REFERENCE_ROUTE_UNSPECIFIED // Not used. Requests containing this value fail.
    case FUEL_EFFICIENT // Fuel efficient route. Routes labeled with this value are determined to be optimized for parameters such as fuel consumption.
}

enum ExtraComputation: String {
    case EXTRA_COMPUTATION_UNSPECIFIED // Not used. Requests containing this value will fail.
    case TOLLS // Toll information for the route(s).
    case FUEL_CONSUMPTION // Estimated fuel consumption for the route(s).
    case TRAFFIC_ON_POLYLINE // Traffic aware polylines for the route(s).
    case HTML_FORMATTED_NAVIGATION_INSTRUCTIONS // NavigationInstructions presented as a formatted HTML text string. This content is meant to be read as-is. This content is for display only. Do not programmatically parse it.
}

struct Route {
    var routeLabels: [RouteLabel]? = nil // Labels for the Route that are useful to identify specific properties of the route to compare against others.
    var legs: [RouteLeg]? = nil // A collection of legs (path segments between waypoints) that make up the route. Each leg corresponds to the trip between two non-via Waypoints. For example, a route with no intermediate waypoints has only one leg. A route that includes one non-via intermediate waypoint has two legs. A route that includes one via intermediate waypoint has one leg. The order of the legs matches the order of waypoints from origin to intermediates to destination.
    var distanceMeters: Int? = nil // The travel distance of the route, in meters.
    var duration: String? = nil // The length of time needed to navigate the route. If you set the routingPreference to TRAFFIC_UNAWARE, then this value is the same as staticDuration. If you set the routingPreference to either TRAFFIC_AWARE or TRAFFIC_AWARE_OPTIMAL, then this value is calculated taking traffic conditions into account.
    var staticDuration: String? = nil // The duration of travel through the route without taking traffic conditions into consideration.
    var polyline: Polyline? = nil // The overall route polyline. This polyline is the combined polyline of all legs.
    var description: String? = nil // A description of the route.
    var warnings: [String]? = nil // An array of warnings to show when displaying the route.
    var viewport: Viewport? = nil // The viewport bounding box of the polyline.
    var travelAdvisory: RouteTravelAdvisory? = nil // Additional information about the route.
    var optimizedIntermediateWaypointIndex: [Int]? = nil // If you set optimizeWaypointOrder to true, this field contains the optimized ordering of intermediate waypoints. Otherwise, this field is empty. For example, if you give an input of Origin: LA; Intermediate waypoints: Dallas, Bangor, Phoenix; Destination: New York; and the optimized intermediate waypoint order is Phoenix, Dallas, Bangor, then this field contains the values [2, 0, 1]. The index starts with 0 for the first intermediate waypoint provided in the input.
    var localizedValues: RouteLocalizedValues? = nil // Text representations of properties of the Route.
    var routeToken: String? = nil // A web-safe, base64-encoded route token that can be passed to the Navigation SDK, that allows the Navigation SDK to reconstruct the route during navigation, and, in the event of rerouting, honor the original intention when you created the route by calling v2.computeRoutes. Customers should treat this token as an opaque blob. It is not meant for reading or mutating. NOTE: Route.route_token is only available for requests that have set ComputeRoutesRequest.routing_preference to TRAFFIC_AWARE or TRAFFIC_AWARE_OPTIMAL. Route.route_token is not supported for requests that have Via waypoints.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            routeLabels = (json["routeLabels"] as? [String] ?? nil)?.map { j in RouteLabel(rawValue: j as! String)! }
        

        legs = (json["legs"] as? [[String: Any]] ?? nil)?.map { j in RouteLeg(json: j) }
        

        if let jdistanceMeters = json["distanceMeters"] as? Int {
            distanceMeters = jdistanceMeters
        }

        if let jduration = json["duration"] as? String {
            duration = jduration
        }

        if let jstaticDuration = json["staticDuration"] as? String {
            staticDuration = jstaticDuration
        }

        if let jpolyline = json["polyline"] as? [String: Any] {
            polyline = Polyline(json: jpolyline)
        }

        if let jdescription = json["description"] as? String {
            description = jdescription
        }

        warnings = (json["warnings"] as? [String] ?? nil)?.map { j in j as! String }
        

        if let jviewport = json["viewport"] as? [String: Any] {
            viewport = Viewport(json: jviewport)
        }

        if let jtravelAdvisory = json["travelAdvisory"] as? [String: Any] {
            travelAdvisory = RouteTravelAdvisory(json: jtravelAdvisory)
        }

        optimizedIntermediateWaypointIndex = (json["optimizedIntermediateWaypointIndex"] as? [Int] ?? nil)?.map { j in j as! Int }
        

        if let jlocalizedValues = json["localizedValues"] as? [String: Any] {
            localizedValues = RouteLocalizedValues(json: jlocalizedValues)
        }

        if let jrouteToken = json["routeToken"] as? String {
            routeToken = jrouteToken
        }

    }
}

enum RouteLabel: String {
    case ROUTE_LABEL_UNSPECIFIED // Default - not used.
    case DEFAULT_ROUTE // The default "best" route returned for the route computation.
    case DEFAULT_ROUTE_ALTERNATE // An alternative to the default "best" route. Routes like this will be returned when computeAlternativeRoutes is specified.
    case FUEL_EFFICIENT // Fuel efficient route. Routes labeled with this value are determined to be optimized for Eco parameters such as fuel consumption.
}

struct RouteLeg {
    var distanceMeters: Int? = nil // The travel distance of the route leg, in meters.
    var duration: String? = nil // The length of time needed to navigate the leg. If the route_preference is set to TRAFFIC_UNAWARE, then this value is the same as staticDuration. If the route_preference is either TRAFFIC_AWARE or TRAFFIC_AWARE_OPTIMAL, then this value is calculated taking traffic conditions into account.
    var staticDuration: String? = nil // The duration of travel through the leg, calculated without taking traffic conditions into consideration.
    var polyline: Polyline? = nil // The overall polyline for this leg that includes each step's polyline.
    var startLocation: Location? = nil // The start location of this leg. This location might be different from the provided origin. For example, when the provided origin is not near a road, this is a point on the road.
    var endLocation: Location? = nil // The end location of this leg. This location might be different from the provided destination. For example, when the provided destination is not near a road, this is a point on the road.
    var steps: [RouteLegStep]? = nil // An array of steps denoting segments within this leg. Each step represents one navigation instruction.
    var travelAdvisory: RouteLegTravelAdvisory? = nil // Contains the additional information that the user should be informed about, such as possible traffic zone restrictions, on a route leg.
    var localizedValues: RouteLegLocalizedValues? = nil // Text representations of properties of the RouteLeg.
    var stepsOverview: StepsOverview? = nil // Overview information about the steps in this RouteLeg. This field is only populated for TRANSIT routes.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jdistanceMeters = json["distanceMeters"] as? Int {
            distanceMeters = jdistanceMeters
        }

        if let jduration = json["duration"] as? String {
            duration = jduration
        }

        if let jstaticDuration = json["staticDuration"] as? String {
            staticDuration = jstaticDuration
        }

        if let jpolyline = json["polyline"] as? [String: Any] {
            polyline = Polyline(json: jpolyline)
        }

        if let jstartLocation = json["startLocation"] as? [String: Any] {
            startLocation = Location(json: jstartLocation)
        }

        if let jendLocation = json["endLocation"] as? [String: Any] {
            endLocation = Location(json: jendLocation)
        }

        steps = (json["steps"] as? [[String: Any]] ?? nil)?.map { j in RouteLegStep(json: j) }
        

        if let jtravelAdvisory = json["travelAdvisory"] as? [String: Any] {
            travelAdvisory = RouteLegTravelAdvisory(json: jtravelAdvisory)
        }

        if let jlocalizedValues = json["localizedValues"] as? [String: Any] {
            localizedValues = RouteLegLocalizedValues(json: jlocalizedValues)
        }

        if let jstepsOverview = json["stepsOverview"] as? [String: Any] {
            stepsOverview = StepsOverview(json: jstepsOverview)
        }

    }
}

struct Polyline {
    var encodedPolyline: String? = nil // The string encoding of the polyline using the polyline encoding algorithm
    var geoJsonLinestring: Struct format? = nil // Specifies a polyline using the GeoJSON LineString format.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jencodedPolyline = json["encodedPolyline"] as? String {
            encodedPolyline = jencodedPolyline
        }

        if let jgeoJsonLinestring = json["geoJsonLinestring"] as? [String: Any] {
            geoJsonLinestring = Struct format(json: jgeoJsonLinestring)
        }

    }
}

struct RouteLegStep {
    var distanceMeters: Int? = nil // The travel distance of this step, in meters. In some circumstances, this field might not have a value.
    var staticDuration: String? = nil // The duration of travel through this step without taking traffic conditions into consideration. In some circumstances, this field might not have a value.
    var polyline: Polyline? = nil // The polyline associated with this step.
    var startLocation: Location? = nil // The start location of this step.
    var endLocation: Location? = nil // The end location of this step.
    var navigationInstruction: NavigationInstruction? = nil // Navigation instructions.
    var travelAdvisory: RouteLegStepTravelAdvisory? = nil // Contains the additional information that the user should be informed about, such as possible traffic zone restrictions, on a leg step.
    var localizedValues: RouteLegStepLocalizedValues? = nil // Text representations of properties of the RouteLegStep.
    var transitDetails: RouteLegStepTransitDetails? = nil // Details pertaining to this step if the travel mode is TRANSIT.
    var travelMode: RouteTravelMode? = nil // The travel mode used for this step.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jdistanceMeters = json["distanceMeters"] as? Int {
            distanceMeters = jdistanceMeters
        }

        if let jstaticDuration = json["staticDuration"] as? String {
            staticDuration = jstaticDuration
        }

        if let jpolyline = json["polyline"] as? [String: Any] {
            polyline = Polyline(json: jpolyline)
        }

        if let jstartLocation = json["startLocation"] as? [String: Any] {
            startLocation = Location(json: jstartLocation)
        }

        if let jendLocation = json["endLocation"] as? [String: Any] {
            endLocation = Location(json: jendLocation)
        }

        if let jnavigationInstruction = json["navigationInstruction"] as? [String: Any] {
            navigationInstruction = NavigationInstruction(json: jnavigationInstruction)
        }

        if let jtravelAdvisory = json["travelAdvisory"] as? [String: Any] {
            travelAdvisory = RouteLegStepTravelAdvisory(json: jtravelAdvisory)
        }

        if let jlocalizedValues = json["localizedValues"] as? [String: Any] {
            localizedValues = RouteLegStepLocalizedValues(json: jlocalizedValues)
        }

        if let jtransitDetails = json["transitDetails"] as? [String: Any] {
            transitDetails = RouteLegStepTransitDetails(json: jtransitDetails)
        }

        if let jtravelMode = json["travelMode"] as? String {
            travelMode = RouteTravelMode(rawValue: jtravelMode)!
        }

    }
}

struct NavigationInstruction {
    var maneuver: Maneuver? = nil // Encapsulates the navigation instructions for the current step (for example, turn left, merge, or straight). This field determines which icon to display.
    var instructions: String? = nil // Instructions for navigating this step.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jmaneuver = json["maneuver"] as? String {
            maneuver = Maneuver(rawValue: jmaneuver)!
        }

        if let jinstructions = json["instructions"] as? String {
            instructions = jinstructions
        }

    }
}

enum Maneuver: String {
    case MANEUVER_UNSPECIFIED // Not used.
    case TURN_SLIGHT_LEFT // Turn slightly to the left.
    case TURN_SHARP_LEFT // Turn sharply to the left.
    case UTURN_LEFT // Make a left u-turn.
    case TURN_LEFT // Turn left.
    case TURN_SLIGHT_RIGHT // Turn slightly to the right.
    case TURN_SHARP_RIGHT // Turn sharply to the right.
    case UTURN_RIGHT // Make a right u-turn.
    case TURN_RIGHT // Turn right.
    case STRAIGHT // Go straight.
    case RAMP_LEFT // Take the left ramp.
    case RAMP_RIGHT // Take the right ramp.
    case MERGE // Merge into traffic.
    case FORK_LEFT // Take the left fork.
    case FORK_RIGHT // Take the right fork.
    case FERRY // Take the ferry.
    case FERRY_TRAIN // Take the train leading onto the ferry.
    case ROUNDABOUT_LEFT // Turn left at the roundabout.
    case ROUNDABOUT_RIGHT // Turn right at the roundabout.
    case DEPART // Initial maneuver.
    case NAME_CHANGE // Used to indicate a street name change.
}

struct RouteLegStepTravelAdvisory {
    var speedReadingIntervals: [SpeedReadingInterval]? = nil // NOTE: This field is not currently populated.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            speedReadingIntervals = (json["speedReadingIntervals"] as? [[String: Any]] ?? nil)?.map { j in SpeedReadingInterval(json: j) }
        

    }
}

struct RouteLegStepLocalizedValues {
    var distance: LocalizedText? = nil // Travel distance represented in text form.
    var staticDuration: LocalizedText? = nil // Duration without taking traffic conditions into consideration, represented in text form.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jdistance = json["distance"] as? [String: Any] {
            distance = LocalizedText(json: jdistance)
        }

        if let jstaticDuration = json["staticDuration"] as? [String: Any] {
            staticDuration = LocalizedText(json: jstaticDuration)
        }

    }
}

struct RouteLegStepTransitDetails {
    var stopDetails: TransitStopDetails? = nil // Information about the arrival and departure stops for the step.
    var localizedValues: TransitDetailsLocalizedValues? = nil // Text representations of properties of the RouteLegStepTransitDetails.
    var headsign: String? = nil // Specifies the direction in which to travel on this line as marked on the vehicle or at the departure stop. The direction is often the terminus station.
    var headway: String? = nil // Specifies the expected time as a duration between departures from the same stop at this time. For example, with a headway seconds value of 600, you would expect a ten minute wait if you should miss your bus.
    var transitLine: TransitLine? = nil // Information about the transit line used in this step.
    var stopCount: Int? = nil // The number of stops from the departure to the arrival stop. This count includes the arrival stop, but excludes the departure stop. For example, if your route leaves from Stop A, passes through stops B and C, and arrives at stop D, stopCount will return 3.
    var tripShortText: String? = nil // The text that appears in schedules and sign boards to identify a transit trip to passengers. The text should uniquely identify a trip within a service day. For example, "538" is the tripShortText of the Amtrak train that leaves San Jose, CA at 15:10 on weekdays to Sacramento, CA.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jstopDetails = json["stopDetails"] as? [String: Any] {
            stopDetails = TransitStopDetails(json: jstopDetails)
        }

        if let jlocalizedValues = json["localizedValues"] as? [String: Any] {
            localizedValues = TransitDetailsLocalizedValues(json: jlocalizedValues)
        }

        if let jheadsign = json["headsign"] as? String {
            headsign = jheadsign
        }

        if let jheadway = json["headway"] as? String {
            headway = jheadway
        }

        if let jtransitLine = json["transitLine"] as? [String: Any] {
            transitLine = TransitLine(json: jtransitLine)
        }

        if let jstopCount = json["stopCount"] as? Int {
            stopCount = jstopCount
        }

        if let jtripShortText = json["tripShortText"] as? String {
            tripShortText = jtripShortText
        }

    }
}

struct TransitStopDetails {
    var arrivalStop: TransitStop? = nil // Information about the arrival stop for the step.
    var arrivalTime: String? = nil // The estimated time of arrival for the step.
    var departureStop: TransitStop? = nil // Information about the departure stop for the step.
    var departureTime: String? = nil // The estimated time of departure for the step.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jarrivalStop = json["arrivalStop"] as? [String: Any] {
            arrivalStop = TransitStop(json: jarrivalStop)
        }

        if let jarrivalTime = json["arrivalTime"] as? String {
            arrivalTime = jarrivalTime
        }

        if let jdepartureStop = json["departureStop"] as? [String: Any] {
            departureStop = TransitStop(json: jdepartureStop)
        }

        if let jdepartureTime = json["departureTime"] as? String {
            departureTime = jdepartureTime
        }

    }
}

struct TransitStop {
    var name: String? = nil // The name of the transit stop.
    var location: Location? = nil // The location of the stop expressed in latitude/longitude coordinates.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jname = json["name"] as? String {
            name = jname
        }

        if let jlocation = json["location"] as? [String: Any] {
            location = Location(json: jlocation)
        }

    }
}

struct TransitDetailsLocalizedValues {
    var arrivalTime: LocalizedTime? = nil // Time in its formatted text representation with a corresponding time zone.
    var departureTime: LocalizedTime? = nil // Time in its formatted text representation with a corresponding time zone.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jarrivalTime = json["arrivalTime"] as? [String: Any] {
            arrivalTime = LocalizedTime(json: jarrivalTime)
        }

        if let jdepartureTime = json["departureTime"] as? [String: Any] {
            departureTime = LocalizedTime(json: jdepartureTime)
        }

    }
}

struct LocalizedTime {
    var time: LocalizedText? = nil // The time specified as a string in a given time zone.
    var timeZone: String? = nil // Contains the time zone. The value is the name of the time zone as defined in the IANA Time Zone Database, e.g. "America/New_York".

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jtime = json["time"] as? [String: Any] {
            time = LocalizedText(json: jtime)
        }

        if let jtimeZone = json["timeZone"] as? String {
            timeZone = jtimeZone
        }

    }
}

struct TransitLine {
    var agencies: [TransitAgency]? = nil // The transit agency (or agencies) that operates this transit line.
    var name: String? = nil // The full name of this transit line, For example, "8 Avenue Local".
    var uri: String? = nil // the URI for this transit line as provided by the transit agency.
    var color: String? = nil // The color commonly used in signage for this line. Represented in hexadecimal.
    var iconUri: String? = nil // The URI for the icon associated with this line.
    var nameShort: String? = nil // The short name of this transit line. This name will normally be a line number, such as "M7" or "355".
    var textColor: String? = nil // The color commonly used in text on signage for this line. Represented in hexadecimal.
    var vehicle: TransitVehicle? = nil // The type of vehicle that operates on this transit line.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            agencies = (json["agencies"] as? [[String: Any]] ?? nil)?.map { j in TransitAgency(json: j) }
        

        if let jname = json["name"] as? String {
            name = jname
        }

        if let juri = json["uri"] as? String {
            uri = juri
        }

        if let jcolor = json["color"] as? String {
            color = jcolor
        }

        if let jiconUri = json["iconUri"] as? String {
            iconUri = jiconUri
        }

        if let jnameShort = json["nameShort"] as? String {
            nameShort = jnameShort
        }

        if let jtextColor = json["textColor"] as? String {
            textColor = jtextColor
        }

        if let jvehicle = json["vehicle"] as? [String: Any] {
            vehicle = TransitVehicle(json: jvehicle)
        }

    }
}

struct TransitAgency {
    var name: String? = nil // The name of this transit agency.
    var phoneNumber: String? = nil // The transit agency's locale-specific formatted phone number.
    var uri: String? = nil // The transit agency's URI.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jname = json["name"] as? String {
            name = jname
        }

        if let jphoneNumber = json["phoneNumber"] as? String {
            phoneNumber = jphoneNumber
        }

        if let juri = json["uri"] as? String {
            uri = juri
        }

    }
}

struct TransitVehicle {
    var name: LocalizedText? = nil // The name of this vehicle, capitalized.
    var type: TransitVehicleType? = nil // The type of vehicle used.
    var iconUri: String? = nil // The URI for an icon associated with this vehicle type.
    var localIconUri: String? = nil // The URI for the icon associated with this vehicle type, based on the local transport signage.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jname = json["name"] as? [String: Any] {
            name = LocalizedText(json: jname)
        }

        if let jtype = json["type"] as? String {
            type = TransitVehicleType(rawValue: jtype)!
        }

        if let jiconUri = json["iconUri"] as? String {
            iconUri = jiconUri
        }

        if let jlocalIconUri = json["localIconUri"] as? String {
            localIconUri = jlocalIconUri
        }

    }
}

enum TransitVehicleType: String {
    case TRANSIT_VEHICLE_TYPE_UNSPECIFIED // Unused.
    case BUS // Bus.
    case CABLE_CAR // A vehicle that operates on a cable, usually on the ground. Aerial cable cars may be of the type GONDOLA_LIFT.
    case COMMUTER_TRAIN // Commuter rail.
    case FERRY // Ferry.
    case FUNICULAR // A vehicle that is pulled up a steep incline by a cable. A Funicular typically consists of two cars, with each car acting as a counterweight for the other.
    case GONDOLA_LIFT // An aerial cable car.
    case HEAVY_RAIL // Heavy rail.
    case HIGH_SPEED_TRAIN // High speed train.
    case INTERCITY_BUS // Intercity bus.
    case LONG_DISTANCE_TRAIN // Long distance train.
    case METRO_RAIL // Light rail transit.
    case MONORAIL // Monorail.
    case OTHER // All other vehicles.
    case RAIL // Rail.
    case SHARE_TAXI // Share taxi is a kind of bus with the ability to drop off and pick up passengers anywhere on its route.
    case SUBWAY // Underground light rail.
    case TRAM // Above ground light rail.
    case TROLLEYBUS // Trolleybus.
}

struct RouteLegTravelAdvisory {
    var tollInfo: TollInfo? = nil // Contains information about tolls on the specific RouteLeg. This field is only populated if we expect there are tolls on the RouteLeg. If this field is set but the estimatedPrice subfield is not populated, we expect that road contains tolls but we do not know an estimated price. If this field does not exist, then there is no toll on the RouteLeg.
    var speedReadingIntervals: [SpeedReadingInterval]? = nil // Speed reading intervals detailing traffic density. Applicable in case of TRAFFIC_AWARE and TRAFFIC_AWARE_OPTIMAL routing preferences. The intervals cover the entire polyline of the RouteLeg without overlap. The start point of a specified interval is the same as the end point of the preceding interval.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jtollInfo = json["tollInfo"] as? [String: Any] {
            tollInfo = TollInfo(json: jtollInfo)
        }

        speedReadingIntervals = (json["speedReadingIntervals"] as? [[String: Any]] ?? nil)?.map { j in SpeedReadingInterval(json: j) }
        

    }
}

struct RouteLegLocalizedValues {
    var distance: LocalizedText? = nil // Travel distance represented in text form.
    var duration: LocalizedText? = nil // Duration taking traffic conditions into consideration represented in text form. Note: If you did not request traffic information, this value will be the same value as staticDuration.
    var staticDuration: LocalizedText? = nil // Duration without taking traffic conditions into consideration, represented in text form.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jdistance = json["distance"] as? [String: Any] {
            distance = LocalizedText(json: jdistance)
        }

        if let jduration = json["duration"] as? [String: Any] {
            duration = LocalizedText(json: jduration)
        }

        if let jstaticDuration = json["staticDuration"] as? [String: Any] {
            staticDuration = LocalizedText(json: jstaticDuration)
        }

    }
}

struct StepsOverview {
    var multiModalSegments: [MultiModalSegment]? = nil // Summarized information about different multi-modal segments of the RouteLeg.steps. This field is not populated if the RouteLeg does not contain any multi-modal segments in the steps.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            multiModalSegments = (json["multiModalSegments"] as? [[String: Any]] ?? nil)?.map { j in MultiModalSegment(json: j) }
        

    }
}

struct MultiModalSegment {
    var navigationInstruction: NavigationInstruction? = nil // NavigationInstruction for the multi-modal segment.
    var travelMode: RouteTravelMode? = nil // The travel mode of the multi-modal segment.
    var stepStartIndex: Int? = nil // The corresponding RouteLegStep index that is the start of a multi-modal segment.
    var stepEndIndex: Int? = nil // The corresponding RouteLegStep index that is the end of a multi-modal segment.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jnavigationInstruction = json["navigationInstruction"] as? [String: Any] {
            navigationInstruction = NavigationInstruction(json: jnavigationInstruction)
        }

        if let jtravelMode = json["travelMode"] as? String {
            travelMode = RouteTravelMode(rawValue: jtravelMode)!
        }

        if let jstepStartIndex = json["stepStartIndex"] as? Int {
            stepStartIndex = jstepStartIndex
        }

        if let jstepEndIndex = json["stepEndIndex"] as? Int {
            stepEndIndex = jstepEndIndex
        }

    }
}

struct Viewport {
    var low: LatLng? = nil // Required. The low point of the viewport.
    var high: LatLng? = nil // Required. The high point of the viewport.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jlow = json["low"] as? [String: Any] {
            low = LatLng(json: jlow)
        }

        if let jhigh = json["high"] as? [String: Any] {
            high = LatLng(json: jhigh)
        }

    }
}

struct RouteLocalizedValues {
    var distance: LocalizedText? = nil // Travel distance represented in text form.
    var duration: LocalizedText? = nil // Duration taking traffic conditions into consideration, represented in text form. Note: If you did not request traffic information, this value will be the same value as staticDuration.
    var staticDuration: LocalizedText? = nil // Duration without taking traffic conditions into consideration, represented in text form.
    var transitFare: LocalizedText? = nil // Transit fare represented in text form.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jdistance = json["distance"] as? [String: Any] {
            distance = LocalizedText(json: jdistance)
        }

        if let jduration = json["duration"] as? [String: Any] {
            duration = LocalizedText(json: jduration)
        }

        if let jstaticDuration = json["staticDuration"] as? [String: Any] {
            staticDuration = LocalizedText(json: jstaticDuration)
        }

        if let jtransitFare = json["transitFare"] as? [String: Any] {
            transitFare = LocalizedText(json: jtransitFare)
        }

    }
}

struct GeocodingResults {
    var origin: GeocodedWaypoint? = nil // Origin geocoded waypoint.
    var destination: GeocodedWaypoint? = nil // Destination geocoded waypoint.
    var intermediates: [GeocodedWaypoint]? = nil // A list of intermediate geocoded waypoints each containing an index field that corresponds to the zero-based position of the waypoint in the order they were specified in the request.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jorigin = json["origin"] as? [String: Any] {
            origin = GeocodedWaypoint(json: jorigin)
        }

        if let jdestination = json["destination"] as? [String: Any] {
            destination = GeocodedWaypoint(json: jdestination)
        }

        intermediates = (json["intermediates"] as? [[String: Any]] ?? nil)?.map { j in GeocodedWaypoint(json: j) }
        

    }
}

struct GeocodedWaypoint {
    var geocoderStatus: Status? = nil // Indicates the status code resulting from the geocoding operation.
    var type: [String]? = nil // The type(s) of the result, in the form of zero or more type tags. Supported types: Address types and address component types.
    var partialMatch: Bool? = nil // Indicates that the geocoder did not return an exact match for the original request, though it was able to match part of the requested address. You may wish to examine the original request for misspellings and/or an incomplete address.
    var placeId: String? = nil // The place ID for this result.
    var intermediateWaypointRequestIndex: Int? = nil // The index of the corresponding intermediate waypoint in the request. Only populated if the corresponding waypoint is an intermediate waypoint.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jgeocoderStatus = json["geocoderStatus"] as? [String: Any] {
            geocoderStatus = Status(json: jgeocoderStatus)
        }

        type = (json["type"] as? [String] ?? nil)?.map { j in j as! String }
        

        if let jpartialMatch = json["partialMatch"] as? Bool {
            partialMatch = jpartialMatch
        }

        if let jplaceId = json["placeId"] as? String {
            placeId = jplaceId
        }

        if let jintermediateWaypointRequestIndex = json["intermediateWaypointRequestIndex"] as? Int {
            intermediateWaypointRequestIndex = jintermediateWaypointRequestIndex
        }

    }
}

struct FallbackInfo {
    var routingMode: FallbackRoutingMode? = nil // Routing mode used for the response. If fallback was triggered, the mode may be different from routing preference set in the original client request.
    var reason: FallbackReason? = nil // The reason why fallback response was used instead of the original response. This field is only populated when the fallback mode is triggered and the fallback response is returned.

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



enum FallbackRoutingMode: String {
    case FALLBACK_ROUTING_MODE_UNSPECIFIED // Not used.
    case FALLBACK_TRAFFIC_UNAWARE // Indicates the TRAFFIC_UNAWARE RoutingPreference was used to compute the response.
    case FALLBACK_TRAFFIC_AWARE // Indicates the TRAFFIC_AWARE RoutingPreference was used to compute the response.
}

enum FallbackReason: String {
    case FALLBACK_REASON_UNSPECIFIED // No fallback reason specified.
    case SERVER_ERROR // A server error happened while calculating routes with your preferred routing mode, but we were able to return a result calculated by an alternative mode.
    case LATENCY_EXCEEDED // We were not able to finish the calculation with your preferred routing mode on time, but we were able to return a result calculated by an alternative mode.
}


struct LatLng {
    var latitude: Int? = nil // The latitude in degrees. It must be in the range [-90.0, +90.0].
    var longitude: Int? = nil // The longitude in degrees. It must be in the range [-180.0, +180.0].

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jlatitude = json["latitude"] as? Int {
            latitude = jlatitude
        }

        if let jlongitude = json["longitude"] as? Int {
            longitude = jlongitude
        }

    }
}




struct LocalizedText {
    var text: String? = nil // Localized string in the language corresponding to languageCode below.
    var languageCode: String? = nil // The text's BCP-47 language code, such as "en-US" or "sr-Latn".

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
    var latLng: LatLng? = nil // The waypoint's geographic coordinates.
    var heading: Int? = nil // The compass heading associated with the direction of the flow of traffic. This value specifies the side of the road for pickup and drop-off. Heading values can be from 0 to 360, where 0 specifies a heading of due North, 90 specifies a heading of due East, and so on. You can use this field only for DRIVE and TWO_WHEELER RouteTravelMode.

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
    var currencyCode: String? = nil // The three-letter currency code defined in ISO 4217.
    var units: String? = nil // The whole units of the amount. For example if currencyCode is "USD", then 1 unit is one US dollar.
    var nanos: Int? = nil // Number of nano (10^-9) units of the amount. The value must be between -999,999,999 and +999,999,999 inclusive. If units is positive, nanos must be positive or zero. If units is zero, nanos can be positive, zero, or negative. If units is negative, nanos must be negative or zero. For example $-1.75 is represented as units=-1 and nanos=-750,000,000.

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
    var avoidTolls: Bool? = nil // When set to true, avoids toll roads where reasonable, giving preference to routes not containing toll roads. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
    var avoidHighways: Bool? = nil // When set to true, avoids highways where reasonable, giving preference to routes not containing highways. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
    var avoidFerries: Bool? = nil // When set to true, avoids ferries where reasonable, giving preference to routes not containing ferries. Applies only to the DRIVE andTWO_WHEELER RouteTravelMode.
    var avoidIndoor: Bool? = nil // When set to true, avoids navigating indoors where reasonable, giving preference to routes not containing indoor navigation. Applies only to the WALK RouteTravelMode.
    var vehicleInfo: VehicleInfo? = nil // Specifies the vehicle information.
    var tollPasses: [TollPass]? = nil // Encapsulates information about toll passes. If toll passes are provided, the API tries to return the pass price. If toll passes are not provided, the API treats the toll pass as unknown and tries to return the cash price. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.

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



struct VehicleInfo {
    var emissionType: VehicleEmissionType? = nil // Describes the vehicle's emission type. Applies only to the DRIVE RouteTravelMode.

    init(json jsonOrNil: [String: Any]?) {
    guard let json = jsonOrNil else {
        return
    }
    
            if let jemissionType = json["emissionType"] as? String {
            emissionType = VehicleEmissionType(rawValue: jemissionType)!
        }

    }
}

enum VehicleEmissionType: String {
    case VEHICLE_EMISSION_TYPE_UNSPECIFIED // No emission type specified. Default to GASOLINE.
    case GASOLINE // Gasoline/petrol fueled vehicle.
    case ELECTRIC // Electricity powered vehicle.
    case HYBRID // Hybrid fuel (such as gasoline + electric) vehicle.
    case DIESEL // Diesel fueled vehicle.
}

enum TollPass: String {
    case TOLL_PASS_UNSPECIFIED // Not used. If this value is used, then the request fails.
    case AU_ETOLL_TAG // Sydney toll pass. See additional details at https://www.myetoll.com.au.
    case AU_EWAY_TAG // Sydney toll pass. See additional details at https://www.tollpay.com.au.
    case AU_LINKT // Australia-wide toll pass. See additional details at https://www.linkt.com.au/.
    case AR_TELEPASE // Argentina toll pass. See additional details at https://telepase.com.ar
    case BR_AUTO_EXPRESO // Brazil toll pass. See additional details at https://www.autoexpreso.com
    case BR_CONECTCAR // Brazil toll pass. See additional details at https://conectcar.com.
    case BR_MOVE_MAIS // Brazil toll pass. See additional details at https://movemais.com.
    case BR_PASSA_RAPIDO // Brazil toll pass. See additional details at https://pasorapido.gob.do/
    case BR_SEM_PARAR // Brazil toll pass. See additional details at https://www.semparar.com.br.
    case BR_TAGGY // Brazil toll pass. See additional details at https://taggy.com.br.
    case BR_VELOE // Brazil toll pass. See additional details at https://veloe.com.br/site/onde-usar.
    case CA_US_AKWASASNE_SEAWAY_CORPORATE_CARD // Canada to United States border crossing.
    case CA_US_AKWASASNE_SEAWAY_TRANSIT_CARD // Canada to United States border crossing.
    case CA_US_BLUE_WATER_EDGE_PASS // Ontario, Canada to Michigan, United States border crossing.
    case CA_US_CONNEXION // Ontario, Canada to Michigan, United States border crossing.
    case CA_US_NEXUS_CARD // Canada to United States border crossing.
    case ID_E_TOLL // Indonesia. E-card provided by multiple banks used to pay for tolls. All e-cards via banks are charged the same so only one enum value is needed. E.g. - Bank Mandiri https://www.bankmandiri.co.id/e-money - BCA https://www.bca.co.id/flazz - BNI https://www.bni.co.id/id-id/ebanking/tapcash
    case IN_FASTAG // India.
    case IN_LOCAL_HP_PLATE_EXEMPT // India, HP state plate exemption.
    case JP_ETC // Japan ETC. Electronic wireless system to collect tolls. https://www.go-etc.jp/
    case JP_ETC2 // Japan ETC2.0. New version of ETC with further discount and bidirectional communication between devices on vehicles and antennas on the road. https://www.go-etc.jp/etc2/index.html
    case MX_IAVE // Mexico toll pass. https://iave.capufe.gob.mx/#/
    case MX_PASE // Mexico https://www.pase.com.mx
    case MX_QUICKPASS // Mexico  https://operadoravial.com/quick-pass/
    case MX_SISTEMA_TELEPEAJE_CHIHUAHUA // http://appsh.chihuahua.gob.mx/transparencia/?doc=/ingresos/TelepeajeFormato4.pdf
    case MX_TAG_IAVE // Mexico
    case MX_TAG_TELEVIA // Mexico toll pass company. One of many operating in Mexico City. See additional details at https://www.televia.com.mx.
    case MX_TELEVIA // Mexico toll pass company. One of many operating in Mexico City. https://www.televia.com.mx
    case MX_VIAPASS // Mexico toll pass. See additional details at https://www.viapass.com.mx/viapass/web_home.aspx.
    case US_AL_FREEDOM_PASS // AL, USA.
    case US_AK_ANTON_ANDERSON_TUNNEL_BOOK_OF_10_TICKETS // AK, USA.
    case US_CA_FASTRAK // CA, USA.
    case US_CA_FASTRAK_CAV_STICKER // Indicates driver has any FasTrak pass in addition to the DMV issued Clean Air Vehicle (CAV) sticker. https://www.bayareafastrak.org/en/guide/doINeedFlex.shtml
    case US_CO_EXPRESSTOLL // CO, USA.
    case US_CO_GO_PASS // CO, USA.
    case US_DE_EZPASSDE // DE, USA.
    case US_FL_BOB_SIKES_TOLL_BRIDGE_PASS // FL, USA.
    case US_FL_DUNES_COMMUNITY_DEVELOPMENT_DISTRICT_EXPRESSCARD // FL, USA.
    case US_FL_EPASS // FL, USA.
    case US_FL_GIBA_TOLL_PASS // FL, USA.
    case US_FL_LEEWAY // FL, USA.
    case US_FL_SUNPASS // FL, USA.
    case US_FL_SUNPASS_PRO // FL, USA.
    case US_IL_EZPASSIL // IL, USA.
    case US_IL_IPASS // IL, USA.
    case US_IN_EZPASSIN // IN, USA.
    case US_KS_BESTPASS_HORIZON // KS, USA.
    case US_KS_KTAG // KS, USA.
    case US_KS_NATIONALPASS // KS, USA.
    case US_KS_PREPASS_ELITEPASS // KS, USA.
    case US_KY_RIVERLINK // KY, USA.
    case US_LA_GEAUXPASS // LA, USA.
    case US_LA_TOLL_TAG // LA, USA.
    case US_MA_EZPASSMA // MA, USA.
    case US_MD_EZPASSMD // MD, USA.
    case US_ME_EZPASSME // ME, USA.
    case US_MI_AMBASSADOR_BRIDGE_PREMIER_COMMUTER_CARD // MI, USA.
    case US_MI_BCPASS // MI, USA.
    case US_MI_GROSSE_ILE_TOLL_BRIDGE_PASS_TAG // MI, USA.
    case US_MI_IQ_PROX_CARD // MI, USA. Deprecated as this pass type no longer exists.This item is deprecated!
    case US_MI_IQ_TAG // MI, USA.
    case US_MI_MACKINAC_BRIDGE_MAC_PASS // MI, USA.
    case US_MI_NEXPRESS_TOLL // MI, USA.
    case US_MN_EZPASSMN // MN, USA.
    case US_NC_EZPASSNC // NC, USA.
    case US_NC_PEACH_PASS // NC, USA.
    case US_NC_QUICK_PASS // NC, USA.
    case US_NH_EZPASSNH // NH, USA.
    case US_NJ_DOWNBEACH_EXPRESS_PASS // NJ, USA.
    case US_NJ_EZPASSNJ // NJ, USA.
    case US_NY_EXPRESSPASS // NY, USA.
    case US_NY_EZPASSNY // NY, USA.
    case US_OH_EZPASSOH // OH, USA.
    case US_PA_EZPASSPA // PA, USA.
    case US_RI_EZPASSRI // RI, USA.
    case US_SC_PALPASS // SC, USA.
    case US_TX_AVI_TAG // TX, USA.
    case US_TX_BANCPASS // TX, USA.
    case US_TX_DEL_RIO_PASS // TX, USA.
    case US_TX_EFAST_PASS // TX, USA.
    case US_TX_EAGLE_PASS_EXPRESS_CARD // TX, USA.
    case US_TX_EPTOLL // TX, USA.
    case US_TX_EZ_CROSS // TX, USA.
    case US_TX_EZTAG // TX, USA.
    case US_TX_FUEGO_TAG // TX, USA.
    case US_TX_LAREDO_TRADE_TAG // TX, USA.
    case US_TX_PLUSPASS // TX, USA.
    case US_TX_TOLLTAG // TX, USA.
    case US_TX_TXTAG // TX, USA.
    case US_TX_XPRESS_CARD // TX, USA.
    case US_UT_ADAMS_AVE_PARKWAY_EXPRESSCARD // UT, USA.
    case US_VA_EZPASSVA // VA, USA.
    case US_WA_BREEZEBY // WA, USA.
    case US_WA_GOOD_TO_GO // WA, USA.
    case US_WV_EZPASSWV // WV, USA.
    case US_WV_MEMORIAL_BRIDGE_TICKETS // WV, USA.
    case US_WV_MOV_PASS // WV, USA
    case US_WV_NEWELL_TOLL_BRIDGE_TICKET // WV, USA.
}


struct RouteTravelAdvisory {
    var tollInfo: TollInfo? = nil // Contains information about tolls on the route. This field is only populated if tolls are expected on the route. If this field is set, but the estimatedPrice subfield is not populated, then the route contains tolls, but the estimated price is unknown. If this field is not set, then there are no tolls expected on the route.
    var speedReadingIntervals: [SpeedReadingInterval]? = nil // Speed reading intervals detailing traffic density. Applicable in case of TRAFFIC_AWARE and TRAFFIC_AWARE_OPTIMAL routing preferences. The intervals cover the entire polyline of the route without overlap. The start point of a specified interval is the same as the end point of the preceding interval.
    var fuelConsumptionMicroliters: String? = nil // The predicted fuel consumption in microliters.
    var routeRestrictionsPartiallyIgnored: Bool? = nil // Returned route may have restrictions that are not suitable for requested travel mode or route modifiers.
    var transitFare: Money? = nil // If present, contains the total fare or ticket costs on this route This property is only returned for TRANSIT requests and only for routes where fare information is available for all transit steps.

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
    var startPolylinePointIndex: Int? = nil // The starting index of this interval in the polyline.
    var endPolylinePointIndex: Int? = nil // The ending index of this interval in the polyline.
    var speed: Speed? = nil // Traffic speed in this interval.

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



enum Speed: String {
    case SPEED_UNSPECIFIED // Default value. This value is unused.
    case NORMAL // Normal speed, no slowdown is detected.
    case SLOW // Slowdown detected, but no traffic jam formed.
    case TRAFFIC_JAM // Traffic jam detected.
}


struct Status {
    var code: Int? = nil // The status code, which should be an enum value of google.rpc.Code.
    var message: String? = nil // A developer-facing error message, which should be in English. Any user-facing error message should be localized and sent in the google.rpc.Status.details field, or localized by the client.
    var details: [[String: Any]]? = nil // A list of messages that carry the error details. There is a common set of message types for APIs to use.

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

        details = (json["details"] as? [[String: Any]] ?? nil)?.map { j in [String: Any](json: j) }
        

    }
}




struct TollInfo {
    var estimatedPrice: [Money]? = nil // The monetary amount of tolls for the corresponding Route or RouteLeg. This list contains a money amount for each currency that is expected to be charged by the toll stations. Typically this list will contain only one item for routes with tolls in one currency. For international trips, this list may contain multiple items to reflect tolls in different currencies.

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
    var allowedTravelModes: [TransitTravelMode]? = nil // A set of travel modes to use when getting a TRANSIT route. Defaults to all supported modes of travel.
    var routingPreference: TransitRoutingPreference? = nil // A routing preference that, when specified, influences the TRANSIT route returned.

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



enum TransitTravelMode: String {
    case TRANSIT_TRAVEL_MODE_UNSPECIFIED // No transit travel mode specified.
    case BUS // Travel by bus.
    case SUBWAY // Travel by subway.
    case TRAIN // Travel by train.
    case LIGHT_RAIL // Travel by light rail or tram.
    case RAIL // Travel by rail. This is equivalent to a combination of SUBWAY, TRAIN, and LIGHT_RAIL.
}

enum TransitRoutingPreference: String {
    case TRANSIT_ROUTING_PREFERENCE_UNSPECIFIED // No preference specified.
    case LESS_WALKING // Indicates that the calculated route should prefer limited amounts of walking.
    case FEWER_TRANSFERS // Indicates that the calculated route should prefer a limited number of transfers.
}


struct Waypoint {
    var via: Bool? = nil // Marks this waypoint as a milestone rather a stopping point. For each non-via waypoint in the request, the response appends an entry to the legs array to provide the details for stopovers on that leg of the trip. Set this value to true when you want the route to pass through this waypoint without stopping over. Via waypoints don't cause an entry to be added to the legs array, but they do route the journey through the waypoint. You can only set this value on waypoints that are intermediates. The request fails if you set this field on terminal waypoints. If ComputeRoutesRequest.optimize_waypoint_order is set to true then this field cannot be set to true; otherwise, the request fails.
    var vehicleStopover: Bool? = nil // Indicates that the waypoint is meant for vehicles to stop at, where the intention is to either pickup or drop-off. When you set this value, the calculated route won't include non-via waypoints on roads that are unsuitable for pickup and drop-off. This option works only for DRIVE and TWO_WHEELER travel modes, and when the locationType is Location.
    var sideOfRoad: Bool? = nil // Indicates that the location of this waypoint is meant to have a preference for the vehicle to stop at a particular side of road. When you set this value, the route will pass through the location so that the vehicle can stop at the side of road that the location is biased towards from the center of the road. This option works only for 'DRIVE' and 'TWO_WHEELER' RouteTravelMode.
    var location: Location? = nil // A point specified using geographic coordinates, including an optional heading.
    var placeId: String? = nil // The POI Place ID associated with the waypoint.
    var address: String? = nil // Human readable address or a plus code. See https://plus.codes for details.

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




