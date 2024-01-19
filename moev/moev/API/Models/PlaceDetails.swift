import Foundation
struct PlacesDetailsResponse: Codable, Identifiable {
	var id = UUID()
	var html_attributions: [String]? = nil // May contain a set of attributions about this listing which must be             displayed to the user (some listings may not have attribution).
	var result: Place? = nil // 
	var status: PlacesDetailsStatus? = nil // 
	var info_messages: [String]? = nil // 
}

extension PlacesDetailsResponse {
	enum CodingKeys: String, CodingKey {
		case html_attributions
		case result
		case status
		case info_messages
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		html_attributions = try container.decodeIfPresent([String].self, forKey: .html_attributions)
		result = try container.decodeIfPresent(Place.self, forKey: .result)
		status = try container.decodeIfPresent(PlacesDetailsStatus.self, forKey: .status)
		info_messages = try container.decodeIfPresent([String].self, forKey: .info_messages)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(html_attributions, forKey: .html_attributions)
		try container.encodeIfPresent(result, forKey: .result)
		try container.encodeIfPresent(status, forKey: .status)
		try container.encodeIfPresent(info_messages, forKey: .info_messages)
	}
}

extension PlacesDetailsResponse {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		html_attributions = (json["html_attributions"] as? [String] ?? nil)?.map { j in j }
		

		if let jresult = json["result"] as? [String: Any] {
			result = Place(json: jresult)
		}

		if let jstatus = json["status"] as? String {
			status = PlacesDetailsStatus(rawValue: jstatus)!
		}

		info_messages = (json["info_messages"] as? [String] ?? nil)?.map { j in j }
		
	}
}
extension PlacesDetailsResponse {
	static func from(jsonData data: Data) -> PlacesDetailsResponse? {
		let data = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
		return PlacesDetailsResponse(json: data)
	}
}



struct Place: Codable, Identifiable {
	var id = UUID()
	var address_components: [AddressComponent]? = nil // 
	var adr_address: String? = nil // 
	var business_status: String? = nil // 
	var curbside_pickup: Bool? = nil // Specifies if the business supports curbside pickup.
	var current_opening_hours: PlaceOpeningHours? = nil // 
	var delivery: Bool? = nil // Specifies if the business supports delivery.
	var dine_in: Bool? = nil // Specifies if the business supports indoor or outdoor seating             options.
	var editorial_summary: PlaceEditorialSummary? = nil // 
	var formatted_address: String? = nil // 
	var formatted_phone_number: String? = nil // 
	var geometry: Geometry? = nil // 
	var icon: String? = nil // Contains the URL of a suggested icon which may be displayed to the             user when indicating this result on a map.
	var icon_background_color: String? = nil // Contains the default HEX color code for the place's category.
	var icon_mask_base_uri: String? = nil // 
	var international_phone_number: String? = nil // 
	var name: String? = nil // 
	var opening_hours: PlaceOpeningHours? = nil // 
	var permanently_closed: Bool? = nil // 
	var photos: [PlacePhoto]? = nil // 
	var place_id: String? = nil // 
	var plus_code: PlusCode? = nil // 
	var price_level: Double? = nil // 
	var rating: Double? = nil // Contains the place's rating, from 1.0 to 5.0, based on aggregated             user reviews.
	var reference: String? = nil // 
	var reservable: Bool? = nil // Specifies if the place supports reservations.
	var reviews: [PlaceReview]? = nil // 
	var scope: String? = nil // 
	var secondary_opening_hours: [PlaceOpeningHours]? = nil // 
	var serves_beer: Bool? = nil // Specifies if the place serves beer.
	var serves_breakfast: Bool? = nil // Specifies if the place serves breakfast.
	var serves_brunch: Bool? = nil // Specifies if the place serves brunch.
	var serves_dinner: Bool? = nil // Specifies if the place serves dinner.
	var serves_lunch: Bool? = nil // Specifies if the place serves lunch.
	var serves_vegetarian_food: Bool? = nil // Specifies if the place serves vegetarian food.
	var serves_wine: Bool? = nil // Specifies if the place serves wine.
	var takeout: Bool? = nil // Specifies if the business supports takeout.
	var types: [String]? = nil // 
	var url: String? = nil // Contains the URL of the official Google page for this place. This             will be the Google-owned page that contains the best available             information about the place. Applications must link to or embed this             page on any screen that shows detailed results about the place to             the user.
	var user_ratings_total: Double? = nil // The total number of reviews, with or without text, for this place.
	var utc_offset: Double? = nil // Contains the number of minutes this place’s current timezone is             offset from UTC. For example, for places in Sydney, Australia during             daylight saving time this would be 660 (+11 hours from UTC), and for             places in California outside of daylight saving time this would be             -480 (-8 hours from UTC).
	var vicinity: String? = nil // 
	var website: String? = nil // The authoritative website for this place, such as a business'             homepage.
	var wheelchair_accessible_entrance: Bool? = nil // Specifies if the place has an entrance that is             wheelchair-accessible.
}

extension Place {
	enum CodingKeys: String, CodingKey {
		case address_components
		case adr_address
		case business_status
		case curbside_pickup
		case current_opening_hours
		case delivery
		case dine_in
		case editorial_summary
		case formatted_address
		case formatted_phone_number
		case geometry
		case icon
		case icon_background_color
		case icon_mask_base_uri
		case international_phone_number
		case name
		case opening_hours
		case permanently_closed
		case photos
		case place_id
		case plus_code
		case price_level
		case rating
		case reference
		case reservable
		case reviews
		case scope
		case secondary_opening_hours
		case serves_beer
		case serves_breakfast
		case serves_brunch
		case serves_dinner
		case serves_lunch
		case serves_vegetarian_food
		case serves_wine
		case takeout
		case types
		case url
		case user_ratings_total
		case utc_offset
		case vicinity
		case website
		case wheelchair_accessible_entrance
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		address_components = try container.decodeIfPresent([AddressComponent].self, forKey: .address_components)
		adr_address = try container.decodeIfPresent(String.self, forKey: .adr_address)
		business_status = try container.decodeIfPresent(String.self, forKey: .business_status)
		curbside_pickup = try container.decodeIfPresent(Bool.self, forKey: .curbside_pickup)
		current_opening_hours = try container.decodeIfPresent(PlaceOpeningHours.self, forKey: .current_opening_hours)
		delivery = try container.decodeIfPresent(Bool.self, forKey: .delivery)
		dine_in = try container.decodeIfPresent(Bool.self, forKey: .dine_in)
		editorial_summary = try container.decodeIfPresent(PlaceEditorialSummary.self, forKey: .editorial_summary)
		formatted_address = try container.decodeIfPresent(String.self, forKey: .formatted_address)
		formatted_phone_number = try container.decodeIfPresent(String.self, forKey: .formatted_phone_number)
		geometry = try container.decodeIfPresent(Geometry.self, forKey: .geometry)
		icon = try container.decodeIfPresent(String.self, forKey: .icon)
		icon_background_color = try container.decodeIfPresent(String.self, forKey: .icon_background_color)
		icon_mask_base_uri = try container.decodeIfPresent(String.self, forKey: .icon_mask_base_uri)
		international_phone_number = try container.decodeIfPresent(String.self, forKey: .international_phone_number)
		name = try container.decodeIfPresent(String.self, forKey: .name)
		opening_hours = try container.decodeIfPresent(PlaceOpeningHours.self, forKey: .opening_hours)
		permanently_closed = try container.decodeIfPresent(Bool.self, forKey: .permanently_closed)
		photos = try container.decodeIfPresent([PlacePhoto].self, forKey: .photos)
		place_id = try container.decodeIfPresent(String.self, forKey: .place_id)
		plus_code = try container.decodeIfPresent(PlusCode.self, forKey: .plus_code)
		price_level = try container.decodeIfPresent(Double.self, forKey: .price_level)
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
		reference = try container.decodeIfPresent(String.self, forKey: .reference)
		reservable = try container.decodeIfPresent(Bool.self, forKey: .reservable)
		reviews = try container.decodeIfPresent([PlaceReview].self, forKey: .reviews)
		scope = try container.decodeIfPresent(String.self, forKey: .scope)
		secondary_opening_hours = try container.decodeIfPresent([PlaceOpeningHours].self, forKey: .secondary_opening_hours)
		serves_beer = try container.decodeIfPresent(Bool.self, forKey: .serves_beer)
		serves_breakfast = try container.decodeIfPresent(Bool.self, forKey: .serves_breakfast)
		serves_brunch = try container.decodeIfPresent(Bool.self, forKey: .serves_brunch)
		serves_dinner = try container.decodeIfPresent(Bool.self, forKey: .serves_dinner)
		serves_lunch = try container.decodeIfPresent(Bool.self, forKey: .serves_lunch)
		serves_vegetarian_food = try container.decodeIfPresent(Bool.self, forKey: .serves_vegetarian_food)
		serves_wine = try container.decodeIfPresent(Bool.self, forKey: .serves_wine)
		takeout = try container.decodeIfPresent(Bool.self, forKey: .takeout)
		types = try container.decodeIfPresent([String].self, forKey: .types)
		url = try container.decodeIfPresent(String.self, forKey: .url)
		user_ratings_total = try container.decodeIfPresent(Double.self, forKey: .user_ratings_total)
		utc_offset = try container.decodeIfPresent(Double.self, forKey: .utc_offset)
		vicinity = try container.decodeIfPresent(String.self, forKey: .vicinity)
		website = try container.decodeIfPresent(String.self, forKey: .website)
		wheelchair_accessible_entrance = try container.decodeIfPresent(Bool.self, forKey: .wheelchair_accessible_entrance)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(address_components, forKey: .address_components)
		try container.encodeIfPresent(adr_address, forKey: .adr_address)
		try container.encodeIfPresent(business_status, forKey: .business_status)
		try container.encodeIfPresent(curbside_pickup, forKey: .curbside_pickup)
		try container.encodeIfPresent(current_opening_hours, forKey: .current_opening_hours)
		try container.encodeIfPresent(delivery, forKey: .delivery)
		try container.encodeIfPresent(dine_in, forKey: .dine_in)
		try container.encodeIfPresent(editorial_summary, forKey: .editorial_summary)
		try container.encodeIfPresent(formatted_address, forKey: .formatted_address)
		try container.encodeIfPresent(formatted_phone_number, forKey: .formatted_phone_number)
		try container.encodeIfPresent(geometry, forKey: .geometry)
		try container.encodeIfPresent(icon, forKey: .icon)
		try container.encodeIfPresent(icon_background_color, forKey: .icon_background_color)
		try container.encodeIfPresent(icon_mask_base_uri, forKey: .icon_mask_base_uri)
		try container.encodeIfPresent(international_phone_number, forKey: .international_phone_number)
		try container.encodeIfPresent(name, forKey: .name)
		try container.encodeIfPresent(opening_hours, forKey: .opening_hours)
		try container.encodeIfPresent(permanently_closed, forKey: .permanently_closed)
		try container.encodeIfPresent(photos, forKey: .photos)
		try container.encodeIfPresent(place_id, forKey: .place_id)
		try container.encodeIfPresent(plus_code, forKey: .plus_code)
		try container.encodeIfPresent(price_level, forKey: .price_level)
		try container.encodeIfPresent(rating, forKey: .rating)
		try container.encodeIfPresent(reference, forKey: .reference)
		try container.encodeIfPresent(reservable, forKey: .reservable)
		try container.encodeIfPresent(reviews, forKey: .reviews)
		try container.encodeIfPresent(scope, forKey: .scope)
		try container.encodeIfPresent(secondary_opening_hours, forKey: .secondary_opening_hours)
		try container.encodeIfPresent(serves_beer, forKey: .serves_beer)
		try container.encodeIfPresent(serves_breakfast, forKey: .serves_breakfast)
		try container.encodeIfPresent(serves_brunch, forKey: .serves_brunch)
		try container.encodeIfPresent(serves_dinner, forKey: .serves_dinner)
		try container.encodeIfPresent(serves_lunch, forKey: .serves_lunch)
		try container.encodeIfPresent(serves_vegetarian_food, forKey: .serves_vegetarian_food)
		try container.encodeIfPresent(serves_wine, forKey: .serves_wine)
		try container.encodeIfPresent(takeout, forKey: .takeout)
		try container.encodeIfPresent(types, forKey: .types)
		try container.encodeIfPresent(url, forKey: .url)
		try container.encodeIfPresent(user_ratings_total, forKey: .user_ratings_total)
		try container.encodeIfPresent(utc_offset, forKey: .utc_offset)
		try container.encodeIfPresent(vicinity, forKey: .vicinity)
		try container.encodeIfPresent(website, forKey: .website)
		try container.encodeIfPresent(wheelchair_accessible_entrance, forKey: .wheelchair_accessible_entrance)
	}
}

extension Place {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		address_components = (json["address_components"] as? [[String: Any]] ?? nil)?.map { j in AddressComponent(json: j) }
		

		if let jadr_address = json["adr_address"] as? String {
			adr_address = jadr_address
		}

		if let jbusiness_status = json["business_status"] as? String {
			business_status = jbusiness_status
		}

		if let jcurbside_pickup = json["curbside_pickup"] as? Bool {
			curbside_pickup = jcurbside_pickup
		}

		if let jcurrent_opening_hours = json["current_opening_hours"] as? [String: Any] {
			current_opening_hours = PlaceOpeningHours(json: jcurrent_opening_hours)
		}

		if let jdelivery = json["delivery"] as? Bool {
			delivery = jdelivery
		}

		if let jdine_in = json["dine_in"] as? Bool {
			dine_in = jdine_in
		}

		if let jeditorial_summary = json["editorial_summary"] as? [String: Any] {
			editorial_summary = PlaceEditorialSummary(json: jeditorial_summary)
		}

		if let jformatted_address = json["formatted_address"] as? String {
			formatted_address = jformatted_address
		}

		if let jformatted_phone_number = json["formatted_phone_number"] as? String {
			formatted_phone_number = jformatted_phone_number
		}

		if let jgeometry = json["geometry"] as? [String: Any] {
			geometry = Geometry(json: jgeometry)
		}

		if let jicon = json["icon"] as? String {
			icon = jicon
		}

		if let jicon_background_color = json["icon_background_color"] as? String {
			icon_background_color = jicon_background_color
		}

		if let jicon_mask_base_uri = json["icon_mask_base_uri"] as? String {
			icon_mask_base_uri = jicon_mask_base_uri
		}

		if let jinternational_phone_number = json["international_phone_number"] as? String {
			international_phone_number = jinternational_phone_number
		}

		if let jname = json["name"] as? String {
			name = jname
		}

		if let jopening_hours = json["opening_hours"] as? [String: Any] {
			opening_hours = PlaceOpeningHours(json: jopening_hours)
		}

		if let jpermanently_closed = json["permanently_closed"] as? Bool {
			permanently_closed = jpermanently_closed
		}

		photos = (json["photos"] as? [[String: Any]] ?? nil)?.map { j in PlacePhoto(json: j) }
		

		if let jplace_id = json["place_id"] as? String {
			place_id = jplace_id
		}

		if let jplus_code = json["plus_code"] as? [String: Any] {
			plus_code = PlusCode(json: jplus_code)
		}

		if let jprice_level = json["price_level"] as? Double {
			price_level = jprice_level
		}

		if let jrating = json["rating"] as? Double {
			rating = jrating
		}

		if let jreference = json["reference"] as? String {
			reference = jreference
		}

		if let jreservable = json["reservable"] as? Bool {
			reservable = jreservable
		}

		reviews = (json["reviews"] as? [[String: Any]] ?? nil)?.map { j in PlaceReview(json: j) }
		

		if let jscope = json["scope"] as? String {
			scope = jscope
		}

		secondary_opening_hours = (json["secondary_opening_hours"] as? [[String: Any]] ?? nil)?.map { j in PlaceOpeningHours(json: j) }
		

		if let jserves_beer = json["serves_beer"] as? Bool {
			serves_beer = jserves_beer
		}

		if let jserves_breakfast = json["serves_breakfast"] as? Bool {
			serves_breakfast = jserves_breakfast
		}

		if let jserves_brunch = json["serves_brunch"] as? Bool {
			serves_brunch = jserves_brunch
		}

		if let jserves_dinner = json["serves_dinner"] as? Bool {
			serves_dinner = jserves_dinner
		}

		if let jserves_lunch = json["serves_lunch"] as? Bool {
			serves_lunch = jserves_lunch
		}

		if let jserves_vegetarian_food = json["serves_vegetarian_food"] as? Bool {
			serves_vegetarian_food = jserves_vegetarian_food
		}

		if let jserves_wine = json["serves_wine"] as? Bool {
			serves_wine = jserves_wine
		}

		if let jtakeout = json["takeout"] as? Bool {
			takeout = jtakeout
		}

		types = (json["types"] as? [String] ?? nil)?.map { j in j }
		

		if let jurl = json["url"] as? String {
			url = jurl
		}

		if let juser_ratings_total = json["user_ratings_total"] as? Double {
			user_ratings_total = juser_ratings_total
		}

		if let jutc_offset = json["utc_offset"] as? Double {
			utc_offset = jutc_offset
		}

		if let jvicinity = json["vicinity"] as? String {
			vicinity = jvicinity
		}

		if let jwebsite = json["website"] as? String {
			website = jwebsite
		}

		if let jwheelchair_accessible_entrance = json["wheelchair_accessible_entrance"] as? Bool {
			wheelchair_accessible_entrance = jwheelchair_accessible_entrance
		}
	}
}

struct AddressComponent: Codable, Identifiable {
	var id = UUID()
	var long_name: String? = nil // The full text description or name of the address component as             returned by the Geocoder.
	var short_name: String? = nil // An abbreviated textual name for the address component, if available.             For example, an address component for the state of Alaska may have a             long_name of "Alaska" and a short_name of "AK" using the 2-letter             postal abbreviation.
	var types: [String]? = nil // 
}

extension AddressComponent {
	enum CodingKeys: String, CodingKey {
		case long_name
		case short_name
		case types
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		long_name = try container.decodeIfPresent(String.self, forKey: .long_name)
		short_name = try container.decodeIfPresent(String.self, forKey: .short_name)
		types = try container.decodeIfPresent([String].self, forKey: .types)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(long_name, forKey: .long_name)
		try container.encodeIfPresent(short_name, forKey: .short_name)
		try container.encodeIfPresent(types, forKey: .types)
	}
}

extension AddressComponent {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlong_name = json["long_name"] as? String {
			long_name = jlong_name
		}

		if let jshort_name = json["short_name"] as? String {
			short_name = jshort_name
		}

		types = (json["types"] as? [String] ?? nil)?.map { j in j }
		
	}
}

struct PlaceEditorialSummary: Codable, Identifiable {
	var id = UUID()
	var language: String? = nil // The language of the previous fields. May not always be present.
	var overview: String? = nil // A medium-length textual summary of the place.
}

extension PlaceEditorialSummary {
	enum CodingKeys: String, CodingKey {
		case language
		case overview
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		language = try container.decodeIfPresent(String.self, forKey: .language)
		overview = try container.decodeIfPresent(String.self, forKey: .overview)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(language, forKey: .language)
		try container.encodeIfPresent(overview, forKey: .overview)
	}
}

extension PlaceEditorialSummary {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlanguage = json["language"] as? String {
			language = jlanguage
		}

		if let joverview = json["overview"] as? String {
			overview = joverview
		}
	}
}

struct Geometry: Codable, Identifiable {
	var id = UUID()
	var location: LatLngLiteral? = nil // See LatLngLiteral for         more information.
	var viewport: Bounds? = nil // See Bounds for more information.
}

extension Geometry {
	enum CodingKeys: String, CodingKey {
		case location
		case viewport
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		location = try container.decodeIfPresent(LatLngLiteral.self, forKey: .location)
		viewport = try container.decodeIfPresent(Bounds.self, forKey: .viewport)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(location, forKey: .location)
		try container.encodeIfPresent(viewport, forKey: .viewport)
	}
}

extension Geometry {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlocation = json["location"] as? [String: Any] {
			location = LatLngLiteral(json: jlocation)
		}

		if let jviewport = json["viewport"] as? [String: Any] {
			viewport = Bounds(json: jviewport)
		}
	}
}

struct LatLngLiteral: Codable, Identifiable {
	var id = UUID()
	var lat: Double? = nil // Latitude in decimal degrees
	var lng: Double? = nil // Longitude in decimal degrees
}

extension LatLngLiteral {
	enum CodingKeys: String, CodingKey {
		case lat
		case lng
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		lat = try container.decodeIfPresent(Double.self, forKey: .lat)
		lng = try container.decodeIfPresent(Double.self, forKey: .lng)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(lat, forKey: .lat)
		try container.encodeIfPresent(lng, forKey: .lng)
	}
}

extension LatLngLiteral {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlat = json["lat"] as? Double {
			lat = jlat
		}

		if let jlng = json["lng"] as? Double {
			lng = jlng
		}
	}
}

struct Bounds: Codable, Identifiable {
	var id = UUID()
	var northeast: LatLngLiteral? = nil // See LatLngLiteral for         more information.
	var southwest: LatLngLiteral? = nil // See LatLngLiteral for         more information.
}

extension Bounds {
	enum CodingKeys: String, CodingKey {
		case northeast
		case southwest
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		northeast = try container.decodeIfPresent(LatLngLiteral.self, forKey: .northeast)
		southwest = try container.decodeIfPresent(LatLngLiteral.self, forKey: .southwest)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(northeast, forKey: .northeast)
		try container.encodeIfPresent(southwest, forKey: .southwest)
	}
}

extension Bounds {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jnortheast = json["northeast"] as? [String: Any] {
			northeast = LatLngLiteral(json: jnortheast)
		}

		if let jsouthwest = json["southwest"] as? [String: Any] {
			southwest = LatLngLiteral(json: jsouthwest)
		}
	}
}

struct PlaceOpeningHours: Codable, Identifiable {
	var id = UUID()
	var open_now: Bool? = nil // A boolean value indicating if the place is open at the current time.
	var periods: [PlaceOpeningHoursPeriod]? = nil // 
	var special_days: [PlaceSpecialDay]? = nil // 
	var type: String? = nil // 
	var weekday_text: [String]? = nil // An array of strings describing in human-readable text the hours of             the place.
}

extension PlaceOpeningHours {
	enum CodingKeys: String, CodingKey {
		case open_now
		case periods
		case special_days
		case type
		case weekday_text
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		open_now = try container.decodeIfPresent(Bool.self, forKey: .open_now)
		periods = try container.decodeIfPresent([PlaceOpeningHoursPeriod].self, forKey: .periods)
		special_days = try container.decodeIfPresent([PlaceSpecialDay].self, forKey: .special_days)
		type = try container.decodeIfPresent(String.self, forKey: .type)
		weekday_text = try container.decodeIfPresent([String].self, forKey: .weekday_text)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(open_now, forKey: .open_now)
		try container.encodeIfPresent(periods, forKey: .periods)
		try container.encodeIfPresent(special_days, forKey: .special_days)
		try container.encodeIfPresent(type, forKey: .type)
		try container.encodeIfPresent(weekday_text, forKey: .weekday_text)
	}
}

extension PlaceOpeningHours {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jopen_now = json["open_now"] as? Bool {
			open_now = jopen_now
		}

		periods = (json["periods"] as? [[String: Any]] ?? nil)?.map { j in PlaceOpeningHoursPeriod(json: j) }
		

		special_days = (json["special_days"] as? [[String: Any]] ?? nil)?.map { j in PlaceSpecialDay(json: j) }
		

		if let jtype = json["type"] as? String {
			type = jtype
		}

		weekday_text = (json["weekday_text"] as? [String] ?? nil)?.map { j in j }
		
	}
}

struct PlaceOpeningHoursPeriod: Codable, Identifiable {
	var id = UUID()
	var open: PlaceOpeningHoursPeriodDetail? = nil // 
	var close: PlaceOpeningHoursPeriodDetail? = nil // 
}

extension PlaceOpeningHoursPeriod {
	enum CodingKeys: String, CodingKey {
		case open
		case close
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		open = try container.decodeIfPresent(PlaceOpeningHoursPeriodDetail.self, forKey: .open)
		close = try container.decodeIfPresent(PlaceOpeningHoursPeriodDetail.self, forKey: .close)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(open, forKey: .open)
		try container.encodeIfPresent(close, forKey: .close)
	}
}

extension PlaceOpeningHoursPeriod {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jopen = json["open"] as? [String: Any] {
			open = PlaceOpeningHoursPeriodDetail(json: jopen)
		}

		if let jclose = json["close"] as? [String: Any] {
			close = PlaceOpeningHoursPeriodDetail(json: jclose)
		}
	}
}

struct PlaceSpecialDay: Codable, Identifiable {
	var id = UUID()
	var date: String? = nil // A date expressed in RFC3339 format in the local timezone for the             place, for example 2010-12-31.
	var exceptional_hours: Bool? = nil // 
}

extension PlaceSpecialDay {
	enum CodingKeys: String, CodingKey {
		case date
		case exceptional_hours
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		date = try container.decodeIfPresent(String.self, forKey: .date)
		exceptional_hours = try container.decodeIfPresent(Bool.self, forKey: .exceptional_hours)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(date, forKey: .date)
		try container.encodeIfPresent(exceptional_hours, forKey: .exceptional_hours)
	}
}

extension PlaceSpecialDay {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jdate = json["date"] as? String {
			date = jdate
		}

		if let jexceptional_hours = json["exceptional_hours"] as? Bool {
			exceptional_hours = jexceptional_hours
		}
	}
}

struct PlaceOpeningHoursPeriodDetail: Codable, Identifiable {
	var id = UUID()
	var day: Double? = nil // A number from 0–6, corresponding to the days of the week, starting             on Sunday. For example, 2 means Tuesday.
	var time: String? = nil // May contain a time of day in 24-hour hhmm format. Values are in the             range 0000–2359. The time will be reported in the place’s time zone.
	var date: String? = nil // A date expressed in RFC3339 format in the local timezone for the             place, for example 2010-12-31.
	var truncated: Bool? = nil // True if a given period was truncated due to a seven-day cutoff,             where the period starts before midnight on the date of the request             and/or ends at or after midnight on the last day. This property             indicates that the period for open or close can extend past this             seven-day cutoff.
}

extension PlaceOpeningHoursPeriodDetail {
	enum CodingKeys: String, CodingKey {
		case day
		case time
		case date
		case truncated
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		day = try container.decodeIfPresent(Double.self, forKey: .day)
		time = try container.decodeIfPresent(String.self, forKey: .time)
		date = try container.decodeIfPresent(String.self, forKey: .date)
		truncated = try container.decodeIfPresent(Bool.self, forKey: .truncated)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(day, forKey: .day)
		try container.encodeIfPresent(time, forKey: .time)
		try container.encodeIfPresent(date, forKey: .date)
		try container.encodeIfPresent(truncated, forKey: .truncated)
	}
}

extension PlaceOpeningHoursPeriodDetail {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jday = json["day"] as? Double {
			day = jday
		}

		if let jtime = json["time"] as? String {
			time = jtime
		}

		if let jdate = json["date"] as? String {
			date = jdate
		}

		if let jtruncated = json["truncated"] as? Bool {
			truncated = jtruncated
		}
	}
}

struct PlacePhoto: Codable, Identifiable {
	var id = UUID()
	var height: Double? = nil // The height of the photo.
	var html_attributions: [String]? = nil // The HTML attributions for the photo.
	var photo_reference: String? = nil // A string used to identify the photo when you perform a Photo             request.
	var width: Double? = nil // The width of the photo.
}

extension PlacePhoto {
	enum CodingKeys: String, CodingKey {
		case height
		case html_attributions
		case photo_reference
		case width
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		height = try container.decodeIfPresent(Double.self, forKey: .height)
		html_attributions = try container.decodeIfPresent([String].self, forKey: .html_attributions)
		photo_reference = try container.decodeIfPresent(String.self, forKey: .photo_reference)
		width = try container.decodeIfPresent(Double.self, forKey: .width)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(height, forKey: .height)
		try container.encodeIfPresent(html_attributions, forKey: .html_attributions)
		try container.encodeIfPresent(photo_reference, forKey: .photo_reference)
		try container.encodeIfPresent(width, forKey: .width)
	}
}

extension PlacePhoto {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jheight = json["height"] as? Double {
			height = jheight
		}

		html_attributions = (json["html_attributions"] as? [String] ?? nil)?.map { j in j }
		

		if let jphoto_reference = json["photo_reference"] as? String {
			photo_reference = jphoto_reference
		}

		if let jwidth = json["width"] as? Double {
			width = jwidth
		}
	}
}

struct PlusCode: Codable, Identifiable {
	var id = UUID()
	var global_code: String? = nil // 
	var compound_code: String? = nil // 
}

extension PlusCode {
	enum CodingKeys: String, CodingKey {
		case global_code
		case compound_code
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		global_code = try container.decodeIfPresent(String.self, forKey: .global_code)
		compound_code = try container.decodeIfPresent(String.self, forKey: .compound_code)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(global_code, forKey: .global_code)
		try container.encodeIfPresent(compound_code, forKey: .compound_code)
	}
}

extension PlusCode {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jglobal_code = json["global_code"] as? String {
			global_code = jglobal_code
		}

		if let jcompound_code = json["compound_code"] as? String {
			compound_code = jcompound_code
		}
	}
}

struct PlaceReview: Codable, Identifiable {
	var id = UUID()
	var author_name: String? = nil // The name of the user who submitted the review. Anonymous reviews are             attributed to "A Google user".
	var rating: Double? = nil // The user's overall rating for this place. This is a whole number,             ranging from 1 to 5.
	var relative_time_description: String? = nil // The time that the review was submitted in text, relative to the             current time.
	var time: Double? = nil // The time that the review was submitted, measured in the number of             seconds since since midnight, January 1, 1970 UTC.
	var author_url: String? = nil // The URL to the user's Google Maps Local Guides profile, if             available.
	var language: String? = nil // An IETF language code indicating the language of the returned             review.This field contains the main language tag only, and not the             secondary tag indicating country or region. For example, all the             English reviews are tagged as 'en', and not 'en-AU' or 'en-UK' and             so on.This field is empty if there is only a rating with no review             text.
	var original_language: String? = nil // 
	var profile_photo_url: String? = nil // The URL to the user's profile photo, if available.
	var text: String? = nil // 
	var translated: Bool? = nil // A boolean value indicating if the review was translated from the             original language it was written in.If a review has been translated,             corresponding to a value of true, Google recommends that you             indicate this to your users. For example, you can add the following             string, “Translated by Google”, to the review.
}

extension PlaceReview {
	enum CodingKeys: String, CodingKey {
		case author_name
		case rating
		case relative_time_description
		case time
		case author_url
		case language
		case original_language
		case profile_photo_url
		case text
		case translated
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		author_name = try container.decodeIfPresent(String.self, forKey: .author_name)
		rating = try container.decodeIfPresent(Double.self, forKey: .rating)
		relative_time_description = try container.decodeIfPresent(String.self, forKey: .relative_time_description)
		time = try container.decodeIfPresent(Double.self, forKey: .time)
		author_url = try container.decodeIfPresent(String.self, forKey: .author_url)
		language = try container.decodeIfPresent(String.self, forKey: .language)
		original_language = try container.decodeIfPresent(String.self, forKey: .original_language)
		profile_photo_url = try container.decodeIfPresent(String.self, forKey: .profile_photo_url)
		text = try container.decodeIfPresent(String.self, forKey: .text)
		translated = try container.decodeIfPresent(Bool.self, forKey: .translated)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(author_name, forKey: .author_name)
		try container.encodeIfPresent(rating, forKey: .rating)
		try container.encodeIfPresent(relative_time_description, forKey: .relative_time_description)
		try container.encodeIfPresent(time, forKey: .time)
		try container.encodeIfPresent(author_url, forKey: .author_url)
		try container.encodeIfPresent(language, forKey: .language)
		try container.encodeIfPresent(original_language, forKey: .original_language)
		try container.encodeIfPresent(profile_photo_url, forKey: .profile_photo_url)
		try container.encodeIfPresent(text, forKey: .text)
		try container.encodeIfPresent(translated, forKey: .translated)
	}
}

extension PlaceReview {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jauthor_name = json["author_name"] as? String {
			author_name = jauthor_name
		}

		if let jrating = json["rating"] as? Double {
			rating = jrating
		}

		if let jrelative_time_description = json["relative_time_description"] as? String {
			relative_time_description = jrelative_time_description
		}

		if let jtime = json["time"] as? Double {
			time = jtime
		}

		if let jauthor_url = json["author_url"] as? String {
			author_url = jauthor_url
		}

		if let jlanguage = json["language"] as? String {
			language = jlanguage
		}

		if let joriginal_language = json["original_language"] as? String {
			original_language = joriginal_language
		}

		if let jprofile_photo_url = json["profile_photo_url"] as? String {
			profile_photo_url = jprofile_photo_url
		}

		if let jtext = json["text"] as? String {
			text = jtext
		}

		if let jtranslated = json["translated"] as? Bool {
			translated = jtranslated
		}
	}
}

