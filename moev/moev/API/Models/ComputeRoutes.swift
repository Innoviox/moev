import Foundation
struct ComputeRoutesRequest: Codable, Identifiable {
	var id = UUID()
	var origin: Waypoint? = nil // Required. Origin waypoint.
	var destination: Waypoint? = nil // Required. Destination waypoint.
	var intermediates: [Waypoint]? = nil // Optional. A set of waypoints along the route (excluding terminal points), for either stopping at or passing by. Up to 25 intermediate waypoints are supported.
	var travelMode: RouteTravelMode? = nil // Optional. Specifies the mode of transportation.
	var routingPreference: RoutingPreference? = nil // Optional. Specifies how to compute the route. The server attempts to use the selected routing preference to compute the route. If  the routing preference results in an error or an extra long latency, then an error is returned. You can specify this option only when the travelMode is DRIVE or TWO_WHEELER, otherwise the request fails.
	var polylineQuality: PolylineQuality? = nil // Optional. Specifies your preference for the quality of the polyline.
	var polylineEncoding: PolylineEncoding? = nil // Optional. Specifies the preferred encoding for the polyline.
	var departureTime: String? = nil // Optional. The departure time. If you don't set this value, then this value defaults to the time that you made the request. NOTE: You can only specify a departureTime in the past when RouteTravelMode is set to TRANSIT. Transit trips are available for up to 7 days in the past or 100 days in the future.
	var arrivalTime: String? = nil // Optional. The arrival time. NOTE: Can only be set when RouteTravelMode is set to TRANSIT. You can specify either departureTime or arrivalTime, but not both. Transit trips are available for up to 7 days in the past or 100 days in the future.
	var computeAlternativeRoutes: Bool? = nil // Optional. Specifies whether to calculate alternate routes in addition to the route. No alternative routes are returned for requests that have intermediate waypoints.
	var routeModifiers: RouteModifiers? = nil // Optional. A set of conditions to satisfy that affect the way routes are calculated.
	var languageCode: String? = nil // Optional. The BCP-47 language code, such as "en-US" or "sr-Latn". For more information, see Unicode Locale Identifier. See Language Support for the list of supported languages. When you don't provide this value, the display language is inferred from the location of the route request.
	var regionCode: String? = nil // Optional. The region code, specified as a ccTLD ("top-level domain") two-character value. For more information see Country code top-level domains.
	var units: Units? = nil // Optional. Specifies the units of measure for the display fields. These fields include the instruction field in NavigationInstruction. The units of measure used for the route, leg, step distance, and duration are not affected by this value. If you don't provide this value, then the display units are inferred from the location of the first origin.
	var optimizeWaypointOrder: Bool? = nil // Optional. If set to true, the service attempts to minimize the overall cost of the route by re-ordering the specified intermediate waypoints. The request fails if any of the intermediate waypoints is a via waypoint. Use ComputeRoutesResponse.Routes.optimized_intermediate_waypoint_index to find the new ordering. If ComputeRoutesResponseroutes.optimized_intermediate_waypoint_index is not requested in the X-Goog-FieldMask header, the request fails. If optimizeWaypointOrder is set to false, ComputeRoutesResponse.optimized_intermediate_waypoint_index will be empty.
	var requestedReferenceRoutes: [ReferenceRoute]? = nil // Optional. Specifies what reference routes to calculate as part of the request in addition to the default route. A reference route is a route with a different route calculation objective than the default route. For example a FUEL_EFFICIENT reference route calculation takes into account various parameters that would generate an optimal fuel efficient route.
	var extraComputations: [ExtraComputation]? = nil // Optional. A list of extra computations which may be used to complete the request. Note: These extra computations may return extra fields on the response. These extra fields must also be specified in the field mask to be returned in the response.
	var trafficModel: TrafficModel? = nil // Optional. Specifies the assumptions to use when calculating time in traffic. This setting affects the value returned in the duration field in the Route and RouteLeg which contains the predicted time in traffic based on historical averages. TrafficModel is only available for requests that have set RoutingPreference to TRAFFIC_AWARE_OPTIMAL and RouteTravelMode to DRIVE. Defaults to BEST_GUESS if traffic is requested and TrafficModel is not specified.
	var transitPreferences: TransitPreferences? = nil // Optional. Specifies preferences that influence the route returned for TRANSIT routes. NOTE: You can only specify a transitPreferences when RouteTravelMode is set to TRANSIT.
}

extension ComputeRoutesRequest {
	enum CodingKeys: String, CodingKey {
		case origin
		case destination
		case intermediates
		case travelMode
		case routingPreference
		case polylineQuality
		case polylineEncoding
		case departureTime
		case arrivalTime
		case computeAlternativeRoutes
		case routeModifiers
		case languageCode
		case regionCode
		case units
		case optimizeWaypointOrder
		case requestedReferenceRoutes
		case extraComputations
		case trafficModel
		case transitPreferences
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		origin = try container.decodeIfPresent(Waypoint.self, forKey: .origin)
		destination = try container.decodeIfPresent(Waypoint.self, forKey: .destination)
		intermediates = try container.decodeIfPresent([Waypoint].self, forKey: .intermediates)
		travelMode = try container.decodeIfPresent(RouteTravelMode.self, forKey: .travelMode)
		routingPreference = try container.decodeIfPresent(RoutingPreference.self, forKey: .routingPreference)
		polylineQuality = try container.decodeIfPresent(PolylineQuality.self, forKey: .polylineQuality)
		polylineEncoding = try container.decodeIfPresent(PolylineEncoding.self, forKey: .polylineEncoding)
		departureTime = try container.decodeIfPresent(String.self, forKey: .departureTime)
		arrivalTime = try container.decodeIfPresent(String.self, forKey: .arrivalTime)
		computeAlternativeRoutes = try container.decodeIfPresent(Bool.self, forKey: .computeAlternativeRoutes)
		routeModifiers = try container.decodeIfPresent(RouteModifiers.self, forKey: .routeModifiers)
		languageCode = try container.decodeIfPresent(String.self, forKey: .languageCode)
		regionCode = try container.decodeIfPresent(String.self, forKey: .regionCode)
		units = try container.decodeIfPresent(Units.self, forKey: .units)
		optimizeWaypointOrder = try container.decodeIfPresent(Bool.self, forKey: .optimizeWaypointOrder)
		requestedReferenceRoutes = try container.decodeIfPresent([ReferenceRoute].self, forKey: .requestedReferenceRoutes)
		extraComputations = try container.decodeIfPresent([ExtraComputation].self, forKey: .extraComputations)
		trafficModel = try container.decodeIfPresent(TrafficModel.self, forKey: .trafficModel)
		transitPreferences = try container.decodeIfPresent(TransitPreferences.self, forKey: .transitPreferences)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(origin, forKey: .origin)
		try container.encodeIfPresent(destination, forKey: .destination)
		try container.encodeIfPresent(intermediates, forKey: .intermediates)
		try container.encodeIfPresent(travelMode, forKey: .travelMode)
		try container.encodeIfPresent(routingPreference, forKey: .routingPreference)
		try container.encodeIfPresent(polylineQuality, forKey: .polylineQuality)
		try container.encodeIfPresent(polylineEncoding, forKey: .polylineEncoding)
		try container.encodeIfPresent(departureTime, forKey: .departureTime)
		try container.encodeIfPresent(arrivalTime, forKey: .arrivalTime)
		try container.encodeIfPresent(computeAlternativeRoutes, forKey: .computeAlternativeRoutes)
		try container.encodeIfPresent(routeModifiers, forKey: .routeModifiers)
		try container.encodeIfPresent(languageCode, forKey: .languageCode)
		try container.encodeIfPresent(regionCode, forKey: .regionCode)
		try container.encodeIfPresent(units, forKey: .units)
		try container.encodeIfPresent(optimizeWaypointOrder, forKey: .optimizeWaypointOrder)
		try container.encodeIfPresent(requestedReferenceRoutes, forKey: .requestedReferenceRoutes)
		try container.encodeIfPresent(extraComputations, forKey: .extraComputations)
		try container.encodeIfPresent(trafficModel, forKey: .trafficModel)
		try container.encodeIfPresent(transitPreferences, forKey: .transitPreferences)
	}
}

extension ComputeRoutesRequest {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jorigin = json["origin"] as? [String: Any] {
			origin = Waypoint(json: jorigin)
		}

		if let jdestination = json["destination"] as? [String: Any] {
			destination = Waypoint(json: jdestination)
		}

		intermediates = (json["intermediates"] as? [[String: Any]] ?? nil)?.map { j in Waypoint(json: j) }
		

		if let jtravelMode = json["travelMode"] as? String {
			travelMode = RouteTravelMode(rawValue: jtravelMode)!
		}

		if let jroutingPreference = json["routingPreference"] as? String {
			routingPreference = RoutingPreference(rawValue: jroutingPreference)!
		}

		if let jpolylineQuality = json["polylineQuality"] as? String {
			polylineQuality = PolylineQuality(rawValue: jpolylineQuality)!
		}

		if let jpolylineEncoding = json["polylineEncoding"] as? String {
			polylineEncoding = PolylineEncoding(rawValue: jpolylineEncoding)!
		}

		if let jdepartureTime = json["departureTime"] as? String {
			departureTime = jdepartureTime
		}

		if let jarrivalTime = json["arrivalTime"] as? String {
			arrivalTime = jarrivalTime
		}

		if let jcomputeAlternativeRoutes = json["computeAlternativeRoutes"] as? Bool {
			computeAlternativeRoutes = jcomputeAlternativeRoutes
		}

		if let jrouteModifiers = json["routeModifiers"] as? [String: Any] {
			routeModifiers = RouteModifiers(json: jrouteModifiers)
		}

		if let jlanguageCode = json["languageCode"] as? String {
			languageCode = jlanguageCode
		}

		if let jregionCode = json["regionCode"] as? String {
			regionCode = jregionCode
		}

		if let junits = json["units"] as? String {
			units = Units(rawValue: junits)!
		}

		if let joptimizeWaypointOrder = json["optimizeWaypointOrder"] as? Bool {
			optimizeWaypointOrder = joptimizeWaypointOrder
		}

		requestedReferenceRoutes = (json["requestedReferenceRoutes"] as? [String] ?? nil)?.map { j in ReferenceRoute(rawValue: j)! }
		

		extraComputations = (json["extraComputations"] as? [String] ?? nil)?.map { j in ExtraComputation(rawValue: j)! }
		

		if let jtrafficModel = json["trafficModel"] as? String {
			trafficModel = TrafficModel(rawValue: jtrafficModel)!
		}

		if let jtransitPreferences = json["transitPreferences"] as? [String: Any] {
			transitPreferences = TransitPreferences(json: jtransitPreferences)
		}
	}
}

struct ComputeRoutesResponse: Codable, Identifiable {
	var id = UUID()
	var routes: [Route]? = nil // Contains an array of computed routes (up to three) when you specify compute_alternatives_routes, and contains just one route when you don't. When this array contains multiple entries, the first one is the most recommended route. If the array is empty, then it means no route could be found.
	var fallbackInfo: FallbackInfo? = nil // In some cases when the server is not able to compute the route results with all of the input preferences, it may fallback to using a different way of computation. When fallback mode is used, this field contains detailed info about the fallback response. Otherwise this field is unset.
	var geocodingResults: GeocodingResults? = nil // Contains geocoding response info for waypoints specified as addresses.
}

extension ComputeRoutesResponse {
	enum CodingKeys: String, CodingKey {
		case routes
		case fallbackInfo
		case geocodingResults
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		routes = try container.decodeIfPresent([Route].self, forKey: .routes)
		fallbackInfo = try container.decodeIfPresent(FallbackInfo.self, forKey: .fallbackInfo)
		geocodingResults = try container.decodeIfPresent(GeocodingResults.self, forKey: .geocodingResults)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(routes, forKey: .routes)
		try container.encodeIfPresent(fallbackInfo, forKey: .fallbackInfo)
		try container.encodeIfPresent(geocodingResults, forKey: .geocodingResults)
	}
}

extension ComputeRoutesResponse {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		routes = (json["routes"] as? [[String: Any]] ?? nil)?.map { j in Route(json: j) }
		

		if let jfallbackInfo = json["fallbackInfo"] as? [String: Any] {
			fallbackInfo = FallbackInfo(json: jfallbackInfo)
		}

		if let jgeocodingResults = json["geocodingResults"] as? [String: Any] {
			geocodingResults = GeocodingResults(json: jgeocodingResults)
		}
	}
}
extension ComputeRoutesResponse {
	static func from(jsonData data: Data) -> ComputeRoutesResponse? {
		let data = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
		return ComputeRoutesResponse(json: data)
	}
}



enum PolylineQuality: String, Codable {
	case POLYLINE_QUALITY_UNSPECIFIED // No polyline quality preference specified. Defaults to OVERVIEW.
	case HIGH_QUALITY // Specifies a high-quality polyline - which is composed using more points than OVERVIEW, at the cost of increased response size. Use this value when you need more precision.
	case OVERVIEW // Specifies an overview polyline - which is composed using a small number of points. Use this value when displaying an overview of the route. Using this option has a lower request latency compared to using the HIGH_QUALITY option.
}

enum PolylineEncoding: String, Codable {
	case POLYLINE_ENCODING_UNSPECIFIED // No polyline type preference specified. Defaults to ENCODED_POLYLINE.
	case ENCODED_POLYLINE // Specifies a polyline encoded using the polyline encoding algorithm.
	case GEO_JSON_LINESTRING // Specifies a polyline using the GeoJSON LineString format
}

enum Units: String, Codable {
	case UNITS_UNSPECIFIED // Units of measure not specified. Defaults to the unit of measure inferred from the request.
	case METRIC // Metric units of measure.
	case IMPERIAL // Imperial (English) units of measure.
}

enum ReferenceRoute: String, Codable {
	case REFERENCE_ROUTE_UNSPECIFIED // Not used. Requests containing this value fail.
	case FUEL_EFFICIENT // Fuel efficient route. Routes labeled with this value are determined to be optimized for parameters such as fuel consumption.
}

enum ExtraComputation: String, Codable {
	case EXTRA_COMPUTATION_UNSPECIFIED // Not used. Requests containing this value will fail.
	case TOLLS // Toll information for the route(s).
	case FUEL_CONSUMPTION // Estimated fuel consumption for the route(s).
	case TRAFFIC_ON_POLYLINE // Traffic aware polylines for the route(s).
	case HTML_FORMATTED_NAVIGATION_INSTRUCTIONS // NavigationInstructions presented as a formatted HTML text string. This content is meant to be read as-is. This content is for display only. Do not programmatically parse it.
}

struct Route: Codable, Identifiable {
	var id = UUID()
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
}

extension Route {
	enum CodingKeys: String, CodingKey {
		case routeLabels
		case legs
		case distanceMeters
		case duration
		case staticDuration
		case polyline
		case description
		case warnings
		case viewport
		case travelAdvisory
		case optimizedIntermediateWaypointIndex
		case localizedValues
		case routeToken
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		routeLabels = try container.decodeIfPresent([RouteLabel].self, forKey: .routeLabels)
		legs = try container.decodeIfPresent([RouteLeg].self, forKey: .legs)
		distanceMeters = try container.decodeIfPresent(Int.self, forKey: .distanceMeters)
		duration = try container.decodeIfPresent(String.self, forKey: .duration)
		staticDuration = try container.decodeIfPresent(String.self, forKey: .staticDuration)
		polyline = try container.decodeIfPresent(Polyline.self, forKey: .polyline)
		description = try container.decodeIfPresent(String.self, forKey: .description)
		warnings = try container.decodeIfPresent([String].self, forKey: .warnings)
		viewport = try container.decodeIfPresent(Viewport.self, forKey: .viewport)
		travelAdvisory = try container.decodeIfPresent(RouteTravelAdvisory.self, forKey: .travelAdvisory)
		optimizedIntermediateWaypointIndex = try container.decodeIfPresent([Int].self, forKey: .optimizedIntermediateWaypointIndex)
		localizedValues = try container.decodeIfPresent(RouteLocalizedValues.self, forKey: .localizedValues)
		routeToken = try container.decodeIfPresent(String.self, forKey: .routeToken)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(routeLabels, forKey: .routeLabels)
		try container.encodeIfPresent(legs, forKey: .legs)
		try container.encodeIfPresent(distanceMeters, forKey: .distanceMeters)
		try container.encodeIfPresent(duration, forKey: .duration)
		try container.encodeIfPresent(staticDuration, forKey: .staticDuration)
		try container.encodeIfPresent(polyline, forKey: .polyline)
		try container.encodeIfPresent(description, forKey: .description)
		try container.encodeIfPresent(warnings, forKey: .warnings)
		try container.encodeIfPresent(viewport, forKey: .viewport)
		try container.encodeIfPresent(travelAdvisory, forKey: .travelAdvisory)
		try container.encodeIfPresent(optimizedIntermediateWaypointIndex, forKey: .optimizedIntermediateWaypointIndex)
		try container.encodeIfPresent(localizedValues, forKey: .localizedValues)
		try container.encodeIfPresent(routeToken, forKey: .routeToken)
	}
}

extension Route {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		routeLabels = (json["routeLabels"] as? [String] ?? nil)?.map { j in RouteLabel(rawValue: j)! }
		

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

		warnings = (json["warnings"] as? [String] ?? nil)?.map { j in j }
		

		if let jviewport = json["viewport"] as? [String: Any] {
			viewport = Viewport(json: jviewport)
		}

		if let jtravelAdvisory = json["travelAdvisory"] as? [String: Any] {
			travelAdvisory = RouteTravelAdvisory(json: jtravelAdvisory)
		}

		optimizedIntermediateWaypointIndex = (json["optimizedIntermediateWaypointIndex"] as? [Int] ?? nil)?.map { j in j }
		

		if let jlocalizedValues = json["localizedValues"] as? [String: Any] {
			localizedValues = RouteLocalizedValues(json: jlocalizedValues)
		}

		if let jrouteToken = json["routeToken"] as? String {
			routeToken = jrouteToken
		}
	}
}

enum RouteLabel: String, Codable {
	case ROUTE_LABEL_UNSPECIFIED // Default - not used.
	case DEFAULT_ROUTE // The default "best" route returned for the route computation.
	case DEFAULT_ROUTE_ALTERNATE // An alternative to the default "best" route. Routes like this will be returned when computeAlternativeRoutes is specified.
	case FUEL_EFFICIENT // Fuel efficient route. Routes labeled with this value are determined to be optimized for Eco parameters such as fuel consumption.
}

struct RouteLeg: Codable, Identifiable {
	var id = UUID()
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
}

extension RouteLeg {
	enum CodingKeys: String, CodingKey {
		case distanceMeters
		case duration
		case staticDuration
		case polyline
		case startLocation
		case endLocation
		case steps
		case travelAdvisory
		case localizedValues
		case stepsOverview
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		distanceMeters = try container.decodeIfPresent(Int.self, forKey: .distanceMeters)
		duration = try container.decodeIfPresent(String.self, forKey: .duration)
		staticDuration = try container.decodeIfPresent(String.self, forKey: .staticDuration)
		polyline = try container.decodeIfPresent(Polyline.self, forKey: .polyline)
		startLocation = try container.decodeIfPresent(Location.self, forKey: .startLocation)
		endLocation = try container.decodeIfPresent(Location.self, forKey: .endLocation)
		steps = try container.decodeIfPresent([RouteLegStep].self, forKey: .steps)
		travelAdvisory = try container.decodeIfPresent(RouteLegTravelAdvisory.self, forKey: .travelAdvisory)
		localizedValues = try container.decodeIfPresent(RouteLegLocalizedValues.self, forKey: .localizedValues)
		stepsOverview = try container.decodeIfPresent(StepsOverview.self, forKey: .stepsOverview)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(distanceMeters, forKey: .distanceMeters)
		try container.encodeIfPresent(duration, forKey: .duration)
		try container.encodeIfPresent(staticDuration, forKey: .staticDuration)
		try container.encodeIfPresent(polyline, forKey: .polyline)
		try container.encodeIfPresent(startLocation, forKey: .startLocation)
		try container.encodeIfPresent(endLocation, forKey: .endLocation)
		try container.encodeIfPresent(steps, forKey: .steps)
		try container.encodeIfPresent(travelAdvisory, forKey: .travelAdvisory)
		try container.encodeIfPresent(localizedValues, forKey: .localizedValues)
		try container.encodeIfPresent(stepsOverview, forKey: .stepsOverview)
	}
}

extension RouteLeg {
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

struct Polyline: Codable, Identifiable {
	var id = UUID()
	var encodedPolyline: String? = nil // The string encoding of the polyline using the polyline encoding algorithm
	var geoJsonLinestring: [String: Any]? = nil // Specifies a polyline using the GeoJSON LineString format.
}

extension Polyline {
	enum CodingKeys: String, CodingKey {
		case encodedPolyline
		case geoJsonLinestring
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		encodedPolyline = try container.decodeIfPresent(String.self, forKey: .encodedPolyline)
		geoJsonLinestring = try container.decodeIfPresent([String: Any].self, forKey: .geoJsonLinestring)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(encodedPolyline, forKey: .encodedPolyline)
		try container.encodeIfPresent(geoJsonLinestring, forKey: .geoJsonLinestring)
	}
}

extension Polyline {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jencodedPolyline = json["encodedPolyline"] as? String {
			encodedPolyline = jencodedPolyline
		}

		if let jgeoJsonLinestring = json["geoJsonLinestring"] as? [String: Any] {
			geoJsonLinestring = jgeoJsonLinestring
		}
	}
}

struct RouteLegStep: Codable, Identifiable {
	var id = UUID()
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
}

extension RouteLegStep {
	enum CodingKeys: String, CodingKey {
		case distanceMeters
		case staticDuration
		case polyline
		case startLocation
		case endLocation
		case navigationInstruction
		case travelAdvisory
		case localizedValues
		case transitDetails
		case travelMode
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		distanceMeters = try container.decodeIfPresent(Int.self, forKey: .distanceMeters)
		staticDuration = try container.decodeIfPresent(String.self, forKey: .staticDuration)
		polyline = try container.decodeIfPresent(Polyline.self, forKey: .polyline)
		startLocation = try container.decodeIfPresent(Location.self, forKey: .startLocation)
		endLocation = try container.decodeIfPresent(Location.self, forKey: .endLocation)
		navigationInstruction = try container.decodeIfPresent(NavigationInstruction.self, forKey: .navigationInstruction)
		travelAdvisory = try container.decodeIfPresent(RouteLegStepTravelAdvisory.self, forKey: .travelAdvisory)
		localizedValues = try container.decodeIfPresent(RouteLegStepLocalizedValues.self, forKey: .localizedValues)
		transitDetails = try container.decodeIfPresent(RouteLegStepTransitDetails.self, forKey: .transitDetails)
		travelMode = try container.decodeIfPresent(RouteTravelMode.self, forKey: .travelMode)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(distanceMeters, forKey: .distanceMeters)
		try container.encodeIfPresent(staticDuration, forKey: .staticDuration)
		try container.encodeIfPresent(polyline, forKey: .polyline)
		try container.encodeIfPresent(startLocation, forKey: .startLocation)
		try container.encodeIfPresent(endLocation, forKey: .endLocation)
		try container.encodeIfPresent(navigationInstruction, forKey: .navigationInstruction)
		try container.encodeIfPresent(travelAdvisory, forKey: .travelAdvisory)
		try container.encodeIfPresent(localizedValues, forKey: .localizedValues)
		try container.encodeIfPresent(transitDetails, forKey: .transitDetails)
		try container.encodeIfPresent(travelMode, forKey: .travelMode)
	}
}

extension RouteLegStep {
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

struct NavigationInstruction: Codable, Identifiable {
	var id = UUID()
	var maneuver: Maneuver? = nil // Encapsulates the navigation instructions for the current step (for example, turn left, merge, or straight). This field determines which icon to display.
	var instructions: String? = nil // Instructions for navigating this step.
}

extension NavigationInstruction {
	enum CodingKeys: String, CodingKey {
		case maneuver
		case instructions
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		maneuver = try container.decodeIfPresent(Maneuver.self, forKey: .maneuver)
		instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(maneuver, forKey: .maneuver)
		try container.encodeIfPresent(instructions, forKey: .instructions)
	}
}

extension NavigationInstruction {
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

enum Maneuver: String, Codable {
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

struct RouteLegStepTravelAdvisory: Codable, Identifiable {
	var id = UUID()
	var speedReadingIntervals: [SpeedReadingInterval]? = nil // NOTE: This field is not currently populated.
}

extension RouteLegStepTravelAdvisory {
	enum CodingKeys: String, CodingKey {
		case speedReadingIntervals
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		speedReadingIntervals = try container.decodeIfPresent([SpeedReadingInterval].self, forKey: .speedReadingIntervals)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(speedReadingIntervals, forKey: .speedReadingIntervals)
	}
}

extension RouteLegStepTravelAdvisory {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		speedReadingIntervals = (json["speedReadingIntervals"] as? [[String: Any]] ?? nil)?.map { j in SpeedReadingInterval(json: j) }
		
	}
}

struct RouteLegStepLocalizedValues: Codable, Identifiable {
	var id = UUID()
	var distance: LocalizedText? = nil // Travel distance represented in text form.
	var staticDuration: LocalizedText? = nil // Duration without taking traffic conditions into consideration, represented in text form.
}

extension RouteLegStepLocalizedValues {
	enum CodingKeys: String, CodingKey {
		case distance
		case staticDuration
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		distance = try container.decodeIfPresent(LocalizedText.self, forKey: .distance)
		staticDuration = try container.decodeIfPresent(LocalizedText.self, forKey: .staticDuration)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(distance, forKey: .distance)
		try container.encodeIfPresent(staticDuration, forKey: .staticDuration)
	}
}

extension RouteLegStepLocalizedValues {
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

struct RouteLegStepTransitDetails: Codable, Identifiable {
	var id = UUID()
	var stopDetails: TransitStopDetails? = nil // Information about the arrival and departure stops for the step.
	var localizedValues: TransitDetailsLocalizedValues? = nil // Text representations of properties of the RouteLegStepTransitDetails.
	var headsign: String? = nil // Specifies the direction in which to travel on this line as marked on the vehicle or at the departure stop. The direction is often the terminus station.
	var headway: String? = nil // Specifies the expected time as a duration between departures from the same stop at this time. For example, with a headway seconds value of 600, you would expect a ten minute wait if you should miss your bus.
	var transitLine: TransitLine? = nil // Information about the transit line used in this step.
	var stopCount: Int? = nil // The number of stops from the departure to the arrival stop. This count includes the arrival stop, but excludes the departure stop. For example, if your route leaves from Stop A, passes through stops B and C, and arrives at stop D, stopCount will return 3.
	var tripShortText: String? = nil // The text that appears in schedules and sign boards to identify a transit trip to passengers. The text should uniquely identify a trip within a service day. For example, "538" is the tripShortText of the Amtrak train that leaves San Jose, CA at 15:10 on weekdays to Sacramento, CA.
}

extension RouteLegStepTransitDetails {
	enum CodingKeys: String, CodingKey {
		case stopDetails
		case localizedValues
		case headsign
		case headway
		case transitLine
		case stopCount
		case tripShortText
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		stopDetails = try container.decodeIfPresent(TransitStopDetails.self, forKey: .stopDetails)
		localizedValues = try container.decodeIfPresent(TransitDetailsLocalizedValues.self, forKey: .localizedValues)
		headsign = try container.decodeIfPresent(String.self, forKey: .headsign)
		headway = try container.decodeIfPresent(String.self, forKey: .headway)
		transitLine = try container.decodeIfPresent(TransitLine.self, forKey: .transitLine)
		stopCount = try container.decodeIfPresent(Int.self, forKey: .stopCount)
		tripShortText = try container.decodeIfPresent(String.self, forKey: .tripShortText)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(stopDetails, forKey: .stopDetails)
		try container.encodeIfPresent(localizedValues, forKey: .localizedValues)
		try container.encodeIfPresent(headsign, forKey: .headsign)
		try container.encodeIfPresent(headway, forKey: .headway)
		try container.encodeIfPresent(transitLine, forKey: .transitLine)
		try container.encodeIfPresent(stopCount, forKey: .stopCount)
		try container.encodeIfPresent(tripShortText, forKey: .tripShortText)
	}
}

extension RouteLegStepTransitDetails {
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

struct TransitStopDetails: Codable, Identifiable {
	var id = UUID()
	var arrivalStop: TransitStop? = nil // Information about the arrival stop for the step.
	var arrivalTime: String? = nil // The estimated time of arrival for the step.
	var departureStop: TransitStop? = nil // Information about the departure stop for the step.
	var departureTime: String? = nil // The estimated time of departure for the step.
}

extension TransitStopDetails {
	enum CodingKeys: String, CodingKey {
		case arrivalStop
		case arrivalTime
		case departureStop
		case departureTime
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		arrivalStop = try container.decodeIfPresent(TransitStop.self, forKey: .arrivalStop)
		arrivalTime = try container.decodeIfPresent(String.self, forKey: .arrivalTime)
		departureStop = try container.decodeIfPresent(TransitStop.self, forKey: .departureStop)
		departureTime = try container.decodeIfPresent(String.self, forKey: .departureTime)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(arrivalStop, forKey: .arrivalStop)
		try container.encodeIfPresent(arrivalTime, forKey: .arrivalTime)
		try container.encodeIfPresent(departureStop, forKey: .departureStop)
		try container.encodeIfPresent(departureTime, forKey: .departureTime)
	}
}

extension TransitStopDetails {
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

struct TransitStop: Codable, Identifiable {
	var id = UUID()
	var name: String? = nil // The name of the transit stop.
	var location: Location? = nil // The location of the stop expressed in latitude/longitude coordinates.
}

extension TransitStop {
	enum CodingKeys: String, CodingKey {
		case name
		case location
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decodeIfPresent(String.self, forKey: .name)
		location = try container.decodeIfPresent(Location.self, forKey: .location)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(location, forKey: .location)
	}
}

extension TransitStop {
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

struct TransitDetailsLocalizedValues: Codable, Identifiable {
	var id = UUID()
	var arrivalTime: LocalizedTime? = nil // Time in its formatted text representation with a corresponding time zone.
	var departureTime: LocalizedTime? = nil // Time in its formatted text representation with a corresponding time zone.
}

extension TransitDetailsLocalizedValues {
	enum CodingKeys: String, CodingKey {
		case arrivalTime
		case departureTime
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		arrivalTime = try container.decodeIfPresent(LocalizedTime.self, forKey: .arrivalTime)
		departureTime = try container.decodeIfPresent(LocalizedTime.self, forKey: .departureTime)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(arrivalTime, forKey: .arrivalTime)
		try container.encodeIfPresent(departureTime, forKey: .departureTime)
	}
}

extension TransitDetailsLocalizedValues {
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

struct LocalizedTime: Codable, Identifiable {
	var id = UUID()
	var time: LocalizedText? = nil // The time specified as a string in a given time zone.
	var timeZone: String? = nil // Contains the time zone. The value is the name of the time zone as defined in the IANA Time Zone Database, e.g. "America/New_York".
}

extension LocalizedTime {
	enum CodingKeys: String, CodingKey {
		case time
		case timeZone
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		time = try container.decodeIfPresent(LocalizedText.self, forKey: .time)
		timeZone = try container.decodeIfPresent(String.self, forKey: .timeZone)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(time, forKey: .time)
		try container.encodeIfPresent(timeZone, forKey: .timeZone)
	}
}

extension LocalizedTime {
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

struct TransitLine: Codable, Identifiable {
	var id = UUID()
	var agencies: [TransitAgency]? = nil // The transit agency (or agencies) that operates this transit line.
	var name: String? = nil // The full name of this transit line, For example, "8 Avenue Local".
	var uri: String? = nil // the URI for this transit line as provided by the transit agency.
	var color: String? = nil // The color commonly used in signage for this line. Represented in hexadecimal.
	var iconUri: String? = nil // The URI for the icon associated with this line.
	var nameShort: String? = nil // The short name of this transit line. This name will normally be a line number, such as "M7" or "355".
	var textColor: String? = nil // The color commonly used in text on signage for this line. Represented in hexadecimal.
	var vehicle: TransitVehicle? = nil // The type of vehicle that operates on this transit line.
}

extension TransitLine {
	enum CodingKeys: String, CodingKey {
		case agencies
		case name
		case uri
		case color
		case iconUri
		case nameShort
		case textColor
		case vehicle
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		agencies = try container.decodeIfPresent([TransitAgency].self, forKey: .agencies)
		name = try container.decodeIfPresent(String.self, forKey: .name)
		uri = try container.decodeIfPresent(String.self, forKey: .uri)
		color = try container.decodeIfPresent(String.self, forKey: .color)
		iconUri = try container.decodeIfPresent(String.self, forKey: .iconUri)
		nameShort = try container.decodeIfPresent(String.self, forKey: .nameShort)
		textColor = try container.decodeIfPresent(String.self, forKey: .textColor)
		vehicle = try container.decodeIfPresent(TransitVehicle.self, forKey: .vehicle)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(agencies, forKey: .agencies)
		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(uri, forKey: .uri)
		try container.encodeIfPresent(color, forKey: .color)
		try container.encodeIfPresent(iconUri, forKey: .iconUri)
		try container.encodeIfPresent(nameShort, forKey: .nameShort)
		try container.encodeIfPresent(textColor, forKey: .textColor)
		try container.encodeIfPresent(vehicle, forKey: .vehicle)
	}
}

extension TransitLine {
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

struct TransitAgency: Codable, Identifiable {
	var id = UUID()
	var name: String? = nil // The name of this transit agency.
	var phoneNumber: String? = nil // The transit agency's locale-specific formatted phone number.
	var uri: String? = nil // The transit agency's URI.
}

extension TransitAgency {
	enum CodingKeys: String, CodingKey {
		case name
		case phoneNumber
		case uri
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decodeIfPresent(String.self, forKey: .name)
		phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
		uri = try container.decodeIfPresent(String.self, forKey: .uri)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(phoneNumber, forKey: .phoneNumber)
		try container.encodeIfPresent(uri, forKey: .uri)
	}
}

extension TransitAgency {
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

struct TransitVehicle: Codable, Identifiable {
	var id = UUID()
	var name: LocalizedText? = nil // The name of this vehicle, capitalized.
	var type: TransitVehicleType? = nil // The type of vehicle used.
	var iconUri: String? = nil // The URI for an icon associated with this vehicle type.
	var localIconUri: String? = nil // The URI for the icon associated with this vehicle type, based on the local transport signage.
}

extension TransitVehicle {
	enum CodingKeys: String, CodingKey {
		case name
		case type
		case iconUri
		case localIconUri
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		name = try container.decodeIfPresent(LocalizedText.self, forKey: .name)
		type = try container.decodeIfPresent(TransitVehicleType.self, forKey: .type)
		iconUri = try container.decodeIfPresent(String.self, forKey: .iconUri)
		localIconUri = try container.decodeIfPresent(String.self, forKey: .localIconUri)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(type, forKey: .type)
		try container.encodeIfPresent(iconUri, forKey: .iconUri)
		try container.encodeIfPresent(localIconUri, forKey: .localIconUri)
	}
}

extension TransitVehicle {
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

enum TransitVehicleType: String, Codable {
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

struct RouteLegTravelAdvisory: Codable, Identifiable {
	var id = UUID()
	var tollInfo: TollInfo? = nil // Contains information about tolls on the specific RouteLeg. This field is only populated if we expect there are tolls on the RouteLeg. If this field is set but the estimatedPrice subfield is not populated, we expect that road contains tolls but we do not know an estimated price. If this field does not exist, then there is no toll on the RouteLeg.
	var speedReadingIntervals: [SpeedReadingInterval]? = nil // Speed reading intervals detailing traffic density. Applicable in case of TRAFFIC_AWARE and TRAFFIC_AWARE_OPTIMAL routing preferences. The intervals cover the entire polyline of the RouteLeg without overlap. The start point of a specified interval is the same as the end point of the preceding interval.
}

extension RouteLegTravelAdvisory {
	enum CodingKeys: String, CodingKey {
		case tollInfo
		case speedReadingIntervals
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		tollInfo = try container.decodeIfPresent(TollInfo.self, forKey: .tollInfo)
		speedReadingIntervals = try container.decodeIfPresent([SpeedReadingInterval].self, forKey: .speedReadingIntervals)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(tollInfo, forKey: .tollInfo)
		try container.encodeIfPresent(speedReadingIntervals, forKey: .speedReadingIntervals)
	}
}

extension RouteLegTravelAdvisory {
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

struct RouteLegLocalizedValues: Codable, Identifiable {
	var id = UUID()
	var distance: LocalizedText? = nil // Travel distance represented in text form.
	var duration: LocalizedText? = nil // Duration taking traffic conditions into consideration represented in text form. Note: If you did not request traffic information, this value will be the same value as staticDuration.
	var staticDuration: LocalizedText? = nil // Duration without taking traffic conditions into consideration, represented in text form.
}

extension RouteLegLocalizedValues {
	enum CodingKeys: String, CodingKey {
		case distance
		case duration
		case staticDuration
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		distance = try container.decodeIfPresent(LocalizedText.self, forKey: .distance)
		duration = try container.decodeIfPresent(LocalizedText.self, forKey: .duration)
		staticDuration = try container.decodeIfPresent(LocalizedText.self, forKey: .staticDuration)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(distance, forKey: .distance)
		try container.encodeIfPresent(duration, forKey: .duration)
		try container.encodeIfPresent(staticDuration, forKey: .staticDuration)
	}
}

extension RouteLegLocalizedValues {
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

struct StepsOverview: Codable, Identifiable {
	var id = UUID()
	var multiModalSegments: [MultiModalSegment]? = nil // Summarized information about different multi-modal segments of the RouteLeg.steps. This field is not populated if the RouteLeg does not contain any multi-modal segments in the steps.
}

extension StepsOverview {
	enum CodingKeys: String, CodingKey {
		case multiModalSegments
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		multiModalSegments = try container.decodeIfPresent([MultiModalSegment].self, forKey: .multiModalSegments)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(multiModalSegments, forKey: .multiModalSegments)
	}
}

extension StepsOverview {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		multiModalSegments = (json["multiModalSegments"] as? [[String: Any]] ?? nil)?.map { j in MultiModalSegment(json: j) }
		
	}
}

struct MultiModalSegment: Codable, Identifiable {
	var id = UUID()
	var navigationInstruction: NavigationInstruction? = nil // NavigationInstruction for the multi-modal segment.
	var travelMode: RouteTravelMode? = nil // The travel mode of the multi-modal segment.
	var stepStartIndex: Int? = nil // The corresponding RouteLegStep index that is the start of a multi-modal segment.
	var stepEndIndex: Int? = nil // The corresponding RouteLegStep index that is the end of a multi-modal segment.
}

extension MultiModalSegment {
	enum CodingKeys: String, CodingKey {
		case navigationInstruction
		case travelMode
		case stepStartIndex
		case stepEndIndex
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		navigationInstruction = try container.decodeIfPresent(NavigationInstruction.self, forKey: .navigationInstruction)
		travelMode = try container.decodeIfPresent(RouteTravelMode.self, forKey: .travelMode)
		stepStartIndex = try container.decodeIfPresent(Int.self, forKey: .stepStartIndex)
		stepEndIndex = try container.decodeIfPresent(Int.self, forKey: .stepEndIndex)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(navigationInstruction, forKey: .navigationInstruction)
		try container.encodeIfPresent(travelMode, forKey: .travelMode)
		try container.encodeIfPresent(stepStartIndex, forKey: .stepStartIndex)
		try container.encodeIfPresent(stepEndIndex, forKey: .stepEndIndex)
	}
}

extension MultiModalSegment {
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

struct Viewport: Codable, Identifiable {
	var id = UUID()
	var low: LatLng? = nil // Required. The low point of the viewport.
	var high: LatLng? = nil // Required. The high point of the viewport.
}

extension Viewport {
	enum CodingKeys: String, CodingKey {
		case low
		case high
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		low = try container.decodeIfPresent(LatLng.self, forKey: .low)
		high = try container.decodeIfPresent(LatLng.self, forKey: .high)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(low, forKey: .low)
		try container.encodeIfPresent(high, forKey: .high)
	}
}

extension Viewport {
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

struct RouteLocalizedValues: Codable, Identifiable {
	var id = UUID()
	var distance: LocalizedText? = nil // Travel distance represented in text form.
	var duration: LocalizedText? = nil // Duration taking traffic conditions into consideration, represented in text form. Note: If you did not request traffic information, this value will be the same value as staticDuration.
	var staticDuration: LocalizedText? = nil // Duration without taking traffic conditions into consideration, represented in text form.
	var transitFare: LocalizedText? = nil // Transit fare represented in text form.
}

extension RouteLocalizedValues {
	enum CodingKeys: String, CodingKey {
		case distance
		case duration
		case staticDuration
		case transitFare
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		distance = try container.decodeIfPresent(LocalizedText.self, forKey: .distance)
		duration = try container.decodeIfPresent(LocalizedText.self, forKey: .duration)
		staticDuration = try container.decodeIfPresent(LocalizedText.self, forKey: .staticDuration)
		transitFare = try container.decodeIfPresent(LocalizedText.self, forKey: .transitFare)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(distance, forKey: .distance)
		try container.encodeIfPresent(duration, forKey: .duration)
		try container.encodeIfPresent(staticDuration, forKey: .staticDuration)
		try container.encodeIfPresent(transitFare, forKey: .transitFare)
	}
}

extension RouteLocalizedValues {
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

struct GeocodingResults: Codable, Identifiable {
	var id = UUID()
	var origin: GeocodedWaypoint? = nil // Origin geocoded waypoint.
	var destination: GeocodedWaypoint? = nil // Destination geocoded waypoint.
	var intermediates: [GeocodedWaypoint]? = nil // A list of intermediate geocoded waypoints each containing an index field that corresponds to the zero-based position of the waypoint in the order they were specified in the request.
}

extension GeocodingResults {
	enum CodingKeys: String, CodingKey {
		case origin
		case destination
		case intermediates
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		origin = try container.decodeIfPresent(GeocodedWaypoint.self, forKey: .origin)
		destination = try container.decodeIfPresent(GeocodedWaypoint.self, forKey: .destination)
		intermediates = try container.decodeIfPresent([GeocodedWaypoint].self, forKey: .intermediates)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(origin, forKey: .origin)
		try container.encodeIfPresent(destination, forKey: .destination)
		try container.encodeIfPresent(intermediates, forKey: .intermediates)
	}
}

extension GeocodingResults {
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

struct GeocodedWaypoint: Codable, Identifiable {
	var id = UUID()
	var geocoderStatus: Status? = nil // Indicates the status code resulting from the geocoding operation.
	var type: [String]? = nil // The type(s) of the result, in the form of zero or more type tags. Supported types: Address types and address component types.
	var partialMatch: Bool? = nil // Indicates that the geocoder did not return an exact match for the original request, though it was able to match part of the requested address. You may wish to examine the original request for misspellings and/or an incomplete address.
	var placeId: String? = nil // The place ID for this result.
	var intermediateWaypointRequestIndex: Int? = nil // The index of the corresponding intermediate waypoint in the request. Only populated if the corresponding waypoint is an intermediate waypoint.
}

extension GeocodedWaypoint {
	enum CodingKeys: String, CodingKey {
		case geocoderStatus
		case type
		case partialMatch
		case placeId
		case intermediateWaypointRequestIndex
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		geocoderStatus = try container.decodeIfPresent(Status.self, forKey: .geocoderStatus)
		type = try container.decodeIfPresent([String].self, forKey: .type)
		partialMatch = try container.decodeIfPresent(Bool.self, forKey: .partialMatch)
		placeId = try container.decodeIfPresent(String.self, forKey: .placeId)
		intermediateWaypointRequestIndex = try container.decodeIfPresent(Int.self, forKey: .intermediateWaypointRequestIndex)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(geocoderStatus, forKey: .geocoderStatus)
		try container.encodeIfPresent(type, forKey: .type)
		try container.encodeIfPresent(partialMatch, forKey: .partialMatch)
		try container.encodeIfPresent(placeId, forKey: .placeId)
		try container.encodeIfPresent(intermediateWaypointRequestIndex, forKey: .intermediateWaypointRequestIndex)
	}
}

extension GeocodedWaypoint {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jgeocoderStatus = json["geocoderStatus"] as? [String: Any] {
			geocoderStatus = Status(json: jgeocoderStatus)
		}

		type = (json["type"] as? [String] ?? nil)?.map { j in j }
		

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


struct FallbackInfo: Codable, Identifiable {
	var id = UUID()
	var routingMode: FallbackRoutingMode? = nil // Routing mode used for the response. If fallback was triggered, the mode may be different from routing preference set in the original client request.
	var reason: FallbackReason? = nil // The reason why fallback response was used instead of the original response. This field is only populated when the fallback mode is triggered and the fallback response is returned.
}

extension FallbackInfo {
	enum CodingKeys: String, CodingKey {
		case routingMode
		case reason
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		routingMode = try container.decodeIfPresent(FallbackRoutingMode.self, forKey: .routingMode)
		reason = try container.decodeIfPresent(FallbackReason.self, forKey: .reason)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(routingMode, forKey: .routingMode)
		try container.encodeIfPresent(reason, forKey: .reason)
	}
}

extension FallbackInfo {
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

enum FallbackRoutingMode: String, Codable {
	case FALLBACK_ROUTING_MODE_UNSPECIFIED // Not used.
	case FALLBACK_TRAFFIC_UNAWARE // Indicates the TRAFFIC_UNAWARE RoutingPreference was used to compute the response.
	case FALLBACK_TRAFFIC_AWARE // Indicates the TRAFFIC_AWARE RoutingPreference was used to compute the response.
}

enum FallbackReason: String, Codable {
	case FALLBACK_REASON_UNSPECIFIED // No fallback reason specified.
	case SERVER_ERROR // A server error happened while calculating routes with your preferred routing mode, but we were able to return a result calculated by an alternative mode.
	case LATENCY_EXCEEDED // We were not able to finish the calculation with your preferred routing mode on time, but we were able to return a result calculated by an alternative mode.
}


struct LatLng: Codable, Identifiable {
	var id = UUID()
	var latitude: Double? = nil // The latitude in degrees. It must be in the range [-90.0, +90.0].
	var longitude: Double? = nil // The longitude in degrees. It must be in the range [-180.0, +180.0].
}

extension LatLng {
	enum CodingKeys: String, CodingKey {
		case latitude
		case longitude
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		latitude = try container.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try container.decodeIfPresent(Double.self, forKey: .longitude)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(latitude, forKey: .latitude)
		try container.encodeIfPresent(longitude, forKey: .longitude)
	}
}

extension LatLng {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlatitude = json["latitude"] as? Double {
			latitude = jlatitude
		}

		if let jlongitude = json["longitude"] as? Double {
			longitude = jlongitude
		}
	}
}


struct LocalizedText: Codable, Identifiable {
	var id = UUID()
	var text: String? = nil // Localized string in the language corresponding to languageCode below.
	var languageCode: String? = nil // The text's BCP-47 language code, such as "en-US" or "sr-Latn".
}

extension LocalizedText {
	enum CodingKeys: String, CodingKey {
		case text
		case languageCode
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		text = try container.decodeIfPresent(String.self, forKey: .text)
		languageCode = try container.decodeIfPresent(String.self, forKey: .languageCode)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(text, forKey: .text)
		try container.encodeIfPresent(languageCode, forKey: .languageCode)
	}
}

extension LocalizedText {
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


struct Location: Codable, Identifiable {
	var id = UUID()
	var latLng: LatLng? = nil // The waypoint's geographic coordinates.
	var heading: Int? = nil // The compass heading associated with the direction of the flow of traffic. This value specifies the side of the road for pickup and drop-off. Heading values can be from 0 to 360, where 0 specifies a heading of due North, 90 specifies a heading of due East, and so on. You can use this field only for DRIVE and TWO_WHEELER RouteTravelMode.
}

extension Location {
	enum CodingKeys: String, CodingKey {
		case latLng
		case heading
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		latLng = try container.decodeIfPresent(LatLng.self, forKey: .latLng)
		heading = try container.decodeIfPresent(Int.self, forKey: .heading)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(latLng, forKey: .latLng)
		try container.encodeIfPresent(heading, forKey: .heading)
	}
}

extension Location {
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


struct Money: Codable, Identifiable {
	var id = UUID()
	var currencyCode: String? = nil // The three-letter currency code defined in ISO 4217.
	var units: String? = nil // The whole units of the amount. For example if currencyCode is "USD", then 1 unit is one US dollar.
	var nanos: Int? = nil // Number of nano (10^-9) units of the amount. The value must be between -999,999,999 and +999,999,999 inclusive. If units is positive, nanos must be positive or zero. If units is zero, nanos can be positive, zero, or negative. If units is negative, nanos must be negative or zero. For example $-1.75 is represented as units=-1 and nanos=-750,000,000.
}

extension Money {
	enum CodingKeys: String, CodingKey {
		case currencyCode
		case units
		case nanos
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode)
		units = try container.decodeIfPresent(String.self, forKey: .units)
		nanos = try container.decodeIfPresent(Int.self, forKey: .nanos)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(currencyCode, forKey: .currencyCode)
		try container.encodeIfPresent(units, forKey: .units)
		try container.encodeIfPresent(nanos, forKey: .nanos)
	}
}

extension Money {
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


struct RouteModifiers: Codable, Identifiable {
	var id = UUID()
	var avoidTolls: Bool? = nil // When set to true, avoids toll roads where reasonable, giving preference to routes not containing toll roads. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
	var avoidHighways: Bool? = nil // When set to true, avoids highways where reasonable, giving preference to routes not containing highways. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
	var avoidFerries: Bool? = nil // When set to true, avoids ferries where reasonable, giving preference to routes not containing ferries. Applies only to the DRIVE andTWO_WHEELER RouteTravelMode.
	var avoidIndoor: Bool? = nil // When set to true, avoids navigating indoors where reasonable, giving preference to routes not containing indoor navigation. Applies only to the WALK RouteTravelMode.
	var vehicleInfo: VehicleInfo? = nil // Specifies the vehicle information.
	var tollPasses: [TollPass]? = nil // Encapsulates information about toll passes. If toll passes are provided, the API tries to return the pass price. If toll passes are not provided, the API treats the toll pass as unknown and tries to return the cash price. Applies only to the DRIVE and TWO_WHEELER RouteTravelMode.
}

extension RouteModifiers {
	enum CodingKeys: String, CodingKey {
		case avoidTolls
		case avoidHighways
		case avoidFerries
		case avoidIndoor
		case vehicleInfo
		case tollPasses
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		avoidTolls = try container.decodeIfPresent(Bool.self, forKey: .avoidTolls)
		avoidHighways = try container.decodeIfPresent(Bool.self, forKey: .avoidHighways)
		avoidFerries = try container.decodeIfPresent(Bool.self, forKey: .avoidFerries)
		avoidIndoor = try container.decodeIfPresent(Bool.self, forKey: .avoidIndoor)
		vehicleInfo = try container.decodeIfPresent(VehicleInfo.self, forKey: .vehicleInfo)
		tollPasses = try container.decodeIfPresent([TollPass].self, forKey: .tollPasses)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(avoidTolls, forKey: .avoidTolls)
		try container.encodeIfPresent(avoidHighways, forKey: .avoidHighways)
		try container.encodeIfPresent(avoidFerries, forKey: .avoidFerries)
		try container.encodeIfPresent(avoidIndoor, forKey: .avoidIndoor)
		try container.encodeIfPresent(vehicleInfo, forKey: .vehicleInfo)
		try container.encodeIfPresent(tollPasses, forKey: .tollPasses)
	}
}

extension RouteModifiers {
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

		tollPasses = (json["tollPasses"] as? [String] ?? nil)?.map { j in TollPass(rawValue: j)! }
		
	}
}

struct VehicleInfo: Codable, Identifiable {
	var id = UUID()
	var emissionType: VehicleEmissionType? = nil // Describes the vehicle's emission type. Applies only to the DRIVE RouteTravelMode.
}

extension VehicleInfo {
	enum CodingKeys: String, CodingKey {
		case emissionType
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		emissionType = try container.decodeIfPresent(VehicleEmissionType.self, forKey: .emissionType)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(emissionType, forKey: .emissionType)
	}
}

extension VehicleInfo {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jemissionType = json["emissionType"] as? String {
			emissionType = VehicleEmissionType(rawValue: jemissionType)!
		}
	}
}

enum VehicleEmissionType: String, Codable {
	case VEHICLE_EMISSION_TYPE_UNSPECIFIED // No emission type specified. Default to GASOLINE.
	case GASOLINE // Gasoline/petrol fueled vehicle.
	case ELECTRIC // Electricity powered vehicle.
	case HYBRID // Hybrid fuel (such as gasoline + electric) vehicle.
	case DIESEL // Diesel fueled vehicle.
}

enum TollPass: String, Codable {
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


struct RouteTravelAdvisory: Codable, Identifiable {
	var id = UUID()
	var tollInfo: TollInfo? = nil // Contains information about tolls on the route. This field is only populated if tolls are expected on the route. If this field is set, but the estimatedPrice subfield is not populated, then the route contains tolls, but the estimated price is unknown. If this field is not set, then there are no tolls expected on the route.
	var speedReadingIntervals: [SpeedReadingInterval]? = nil // Speed reading intervals detailing traffic density. Applicable in case of TRAFFIC_AWARE and TRAFFIC_AWARE_OPTIMAL routing preferences. The intervals cover the entire polyline of the route without overlap. The start point of a specified interval is the same as the end point of the preceding interval.
	var fuelConsumptionMicroliters: String? = nil // The predicted fuel consumption in microliters.
	var routeRestrictionsPartiallyIgnored: Bool? = nil // Returned route may have restrictions that are not suitable for requested travel mode or route modifiers.
	var transitFare: Money? = nil // If present, contains the total fare or ticket costs on this route This property is only returned for TRANSIT requests and only for routes where fare information is available for all transit steps.
}

extension RouteTravelAdvisory {
	enum CodingKeys: String, CodingKey {
		case tollInfo
		case speedReadingIntervals
		case fuelConsumptionMicroliters
		case routeRestrictionsPartiallyIgnored
		case transitFare
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		tollInfo = try container.decodeIfPresent(TollInfo.self, forKey: .tollInfo)
		speedReadingIntervals = try container.decodeIfPresent([SpeedReadingInterval].self, forKey: .speedReadingIntervals)
		fuelConsumptionMicroliters = try container.decodeIfPresent(String.self, forKey: .fuelConsumptionMicroliters)
		routeRestrictionsPartiallyIgnored = try container.decodeIfPresent(Bool.self, forKey: .routeRestrictionsPartiallyIgnored)
		transitFare = try container.decodeIfPresent(Money.self, forKey: .transitFare)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(tollInfo, forKey: .tollInfo)
		try container.encodeIfPresent(speedReadingIntervals, forKey: .speedReadingIntervals)
		try container.encodeIfPresent(fuelConsumptionMicroliters, forKey: .fuelConsumptionMicroliters)
		try container.encodeIfPresent(routeRestrictionsPartiallyIgnored, forKey: .routeRestrictionsPartiallyIgnored)
		try container.encodeIfPresent(transitFare, forKey: .transitFare)
	}
}

extension RouteTravelAdvisory {
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


enum RouteTravelMode: String, Codable {
	case TRAVEL_MODE_UNSPECIFIED // No travel mode specified. Defaults to DRIVE.
	case DRIVE // Travel by passenger car.
	case BICYCLE // Travel by bicycle.
	case WALK // Travel by walking.
	case TWO_WHEELER // Two-wheeled, motorized vehicle. For example, motorcycle. Note that this differs from the BICYCLE travel mode which covers human-powered mode.
	case TRANSIT // Travel by public transit routes, where available.
}


enum RoutingPreference: String, Codable {
	case ROUTING_PREFERENCE_UNSPECIFIED // No routing preference specified. Default to TRAFFIC_UNAWARE.
	case TRAFFIC_UNAWARE // Computes routes without taking live traffic conditions into consideration. Suitable when traffic conditions don't matter or are not applicable. Using this value produces the lowest latency. Note: For RouteTravelMode DRIVE and TWO_WHEELER, the route and duration chosen are based on road network and average time-independent traffic conditions, not current road conditions. Consequently, routes may include roads that are temporarily closed. Results for a given request may vary over time due to changes in the road network, updated average traffic conditions, and the distributed nature of the service. Results may also vary between nearly-equivalent routes at any time or frequency.
	case TRAFFIC_AWARE // Calculates routes taking live traffic conditions into consideration. In contrast to TRAFFIC_AWARE_OPTIMAL, some optimizations are applied to significantly reduce latency.
	case TRAFFIC_AWARE_OPTIMAL // Calculates the routes taking live traffic conditions into consideration, without applying most performance optimizations. Using this value produces the highest latency.
}


struct SpeedReadingInterval: Codable, Identifiable {
	var id = UUID()
	var startPolylinePointIndex: Int? = nil // The starting index of this interval in the polyline.
	var endPolylinePointIndex: Int? = nil // The ending index of this interval in the polyline.
	var speed: Speed? = nil // Traffic speed in this interval.
}

extension SpeedReadingInterval {
	enum CodingKeys: String, CodingKey {
		case startPolylinePointIndex
		case endPolylinePointIndex
		case speed
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		startPolylinePointIndex = try container.decodeIfPresent(Int.self, forKey: .startPolylinePointIndex)
		endPolylinePointIndex = try container.decodeIfPresent(Int.self, forKey: .endPolylinePointIndex)
		speed = try container.decodeIfPresent(Speed.self, forKey: .speed)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(startPolylinePointIndex, forKey: .startPolylinePointIndex)
		try container.encodeIfPresent(endPolylinePointIndex, forKey: .endPolylinePointIndex)
		try container.encodeIfPresent(speed, forKey: .speed)
	}
}

extension SpeedReadingInterval {
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

enum Speed: String, Codable {
	case SPEED_UNSPECIFIED // Default value. This value is unused.
	case NORMAL // Normal speed, no slowdown is detected.
	case SLOW // Slowdown detected, but no traffic jam formed.
	case TRAFFIC_JAM // Traffic jam detected.
}


struct Status: Codable, Identifiable {
	var id = UUID()
	var code: Int? = nil // The status code, which should be an enum value of google.rpc.Code.
	var message: String? = nil // A developer-facing error message, which should be in English. Any user-facing error message should be localized and sent in the google.rpc.Status.details field, or localized by the client.
	var details: [[String: Any]]? = nil // A list of messages that carry the error details. There is a common set of message types for APIs to use.
}

extension Status {
	enum CodingKeys: String, CodingKey {
		case code
		case message
		case details
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		code = try container.decodeIfPresent(Int.self, forKey: .code)
		message = try container.decodeIfPresent(String.self, forKey: .message)
		details = try container.decodeIfPresent([[String: Any]].self, forKey: .details)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(code, forKey: .code)
		try container.encodeIfPresent(message, forKey: .message)
		try container.encodeIfPresent(details, forKey: .details)
	}
}

extension Status {
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

		details = (json["details"] as? [[String: Any]] ?? nil)
	}
}


struct TollInfo: Codable, Identifiable {
	var id = UUID()
	var estimatedPrice: [Money]? = nil // The monetary amount of tolls for the corresponding Route or RouteLeg. This list contains a money amount for each currency that is expected to be charged by the toll stations. Typically this list will contain only one item for routes with tolls in one currency. For international trips, this list may contain multiple items to reflect tolls in different currencies.
}

extension TollInfo {
	enum CodingKeys: String, CodingKey {
		case estimatedPrice
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		estimatedPrice = try container.decodeIfPresent([Money].self, forKey: .estimatedPrice)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(estimatedPrice, forKey: .estimatedPrice)
	}
}

extension TollInfo {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		estimatedPrice = (json["estimatedPrice"] as? [[String: Any]] ?? nil)?.map { j in Money(json: j) }
		
	}
}


enum TrafficModel: String, Codable {
	case TRAFFIC_MODEL_UNSPECIFIED // Unused. If specified, will default to BEST_GUESS.
	case BEST_GUESS // Indicates that the returned duration should be the best estimate of travel time given what is known about both historical traffic conditions and live traffic. Live traffic becomes more important the closer the departureTime is to now.
	case PESSIMISTIC // Indicates that the returned duration should be longer than the actual travel time on most days, though occasional days with particularly bad traffic conditions may exceed this value.
	case OPTIMISTIC // Indicates that the returned duration should be shorter than the actual travel time on most days, though occasional days with particularly good traffic conditions may be faster than this value.
}


struct TransitPreferences: Codable, Identifiable {
	var id = UUID()
	var allowedTravelModes: [TransitTravelMode]? = nil // A set of travel modes to use when getting a TRANSIT route. Defaults to all supported modes of travel.
	var routingPreference: TransitRoutingPreference? = nil // A routing preference that, when specified, influences the TRANSIT route returned.
}

extension TransitPreferences {
	enum CodingKeys: String, CodingKey {
		case allowedTravelModes
		case routingPreference
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		allowedTravelModes = try container.decodeIfPresent([TransitTravelMode].self, forKey: .allowedTravelModes)
		routingPreference = try container.decodeIfPresent(TransitRoutingPreference.self, forKey: .routingPreference)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(allowedTravelModes, forKey: .allowedTravelModes)
		try container.encodeIfPresent(routingPreference, forKey: .routingPreference)
	}
}

extension TransitPreferences {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		allowedTravelModes = (json["allowedTravelModes"] as? [String] ?? nil)?.map { j in TransitTravelMode(rawValue: j)! }
		

		if let jroutingPreference = json["routingPreference"] as? String {
			routingPreference = TransitRoutingPreference(rawValue: jroutingPreference)!
		}
	}
}

enum TransitTravelMode: String, Codable {
	case TRANSIT_TRAVEL_MODE_UNSPECIFIED // No transit travel mode specified.
	case BUS // Travel by bus.
	case SUBWAY // Travel by subway.
	case TRAIN // Travel by train.
	case LIGHT_RAIL // Travel by light rail or tram.
	case RAIL // Travel by rail. This is equivalent to a combination of SUBWAY, TRAIN, and LIGHT_RAIL.
}

enum TransitRoutingPreference: String, Codable {
	case TRANSIT_ROUTING_PREFERENCE_UNSPECIFIED // No preference specified.
	case LESS_WALKING // Indicates that the calculated route should prefer limited amounts of walking.
	case FEWER_TRANSFERS // Indicates that the calculated route should prefer a limited number of transfers.
}


struct Waypoint: Codable, Identifiable {
	var id = UUID()
	var via: Bool? = nil // Marks this waypoint as a milestone rather a stopping point. For each non-via waypoint in the request, the response appends an entry to the legs array to provide the details for stopovers on that leg of the trip. Set this value to true when you want the route to pass through this waypoint without stopping over. Via waypoints don't cause an entry to be added to the legs array, but they do route the journey through the waypoint. You can only set this value on waypoints that are intermediates. The request fails if you set this field on terminal waypoints. If ComputeRoutesRequest.optimize_waypoint_order is set to true then this field cannot be set to true; otherwise, the request fails.
	var vehicleStopover: Bool? = nil // Indicates that the waypoint is meant for vehicles to stop at, where the intention is to either pickup or drop-off. When you set this value, the calculated route won't include non-via waypoints on roads that are unsuitable for pickup and drop-off. This option works only for DRIVE and TWO_WHEELER travel modes, and when the locationType is Location.
	var sideOfRoad: Bool? = nil // Indicates that the location of this waypoint is meant to have a preference for the vehicle to stop at a particular side of road. When you set this value, the route will pass through the location so that the vehicle can stop at the side of road that the location is biased towards from the center of the road. This option works only for 'DRIVE' and 'TWO_WHEELER' RouteTravelMode.
	var location: Location? = nil // A point specified using geographic coordinates, including an optional heading.
	var placeId: String? = nil // The POI Place ID associated with the waypoint.
	var address: String? = nil // Human readable address or a plus code. See https://plus.codes for details.
}

extension Waypoint {
	enum CodingKeys: String, CodingKey {
		case via
		case vehicleStopover
		case sideOfRoad
		case location
		case placeId
		case address
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		via = try container.decodeIfPresent(Bool.self, forKey: .via)
		vehicleStopover = try container.decodeIfPresent(Bool.self, forKey: .vehicleStopover)
		sideOfRoad = try container.decodeIfPresent(Bool.self, forKey: .sideOfRoad)
		location = try container.decodeIfPresent(Location.self, forKey: .location)
		placeId = try container.decodeIfPresent(String.self, forKey: .placeId)
		address = try container.decodeIfPresent(String.self, forKey: .address)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(via, forKey: .via)
		try container.encodeIfPresent(vehicleStopover, forKey: .vehicleStopover)
		try container.encodeIfPresent(sideOfRoad, forKey: .sideOfRoad)
		try container.encodeIfPresent(location, forKey: .location)
		try container.encodeIfPresent(placeId, forKey: .placeId)
		try container.encodeIfPresent(address, forKey: .address)
	}
}

extension Waypoint {
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


