import Foundation
struct PlacesDetailsResponse: Codable, Identifiable {
	var id = UUID()
	var html_attributions: [String]? = nil // May contain a set of attributions about this listing which must be             displayed to the user (some listings may not have attribution).
	var result: Place? = nil // 
	var status: PlacesDetailsStatus? = nil // 
	var info_messages: [String]? = nil // 
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
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		address_components = (json["address_components"] as? [[String: Any]] ?? nil)?.map { j in j }
		

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
			geometry = jgeometry
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
			plus_code = jplus_code
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
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlocation = json["location"] as? [String: Any] {
			location = jlocation
		}

		if let jviewport = json["viewport"] as? [String: Any] {
			viewport = jviewport
		}
	}
}

struct LatLngLiteral: Codable, Identifiable {
	var id = UUID()
	var lat: Double? = nil // Latitude in decimal degrees
	var lng: Double? = nil // Longitude in decimal degrees
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
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jnortheast = json["northeast"] as? [String: Any] {
			northeast = jnortheast
		}

		if let jsouthwest = json["southwest"] as? [String: Any] {
			southwest = jsouthwest
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

