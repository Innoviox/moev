import Foundation
struct PlacesDetailsResponse: Codable {
	
	var html_attributions: [String]? = nil // May contain a set of attributions about this listing which must be             displayed to the user (some listings may not have attribution).
	var result: Place? = nil // 
	var status: PlacesDetailsStatus? = nil // 
	var info_messages: [String]? = nil // 
}

extension PlacesDetailsResponse {
    static func from(jsonData data: Data) -> PlacesDetailsResponse? {
        return try? JSONDecoder().decode(PlacesDetailsResponse.self, from: data)
    }
}




struct Place: Codable {
	
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


struct AddressComponent: Codable {
	
	var long_name: String? = nil // The full text description or name of the address component as             returned by the Geocoder.
	var short_name: String? = nil // An abbreviated textual name for the address component, if available.             For example, an address component for the state of Alaska may have a             long_name of "Alaska" and a short_name of "AK" using the 2-letter             postal abbreviation.
	var types: [String]? = nil // 
}


struct PlaceEditorialSummary: Codable {
	
	var language: String? = nil // The language of the previous fields. May not always be present.
	var overview: String? = nil // A medium-length textual summary of the place.
}


struct Geometry: Codable {
	
	var location: LatLngLiteral? = nil // See LatLngLiteral for         more information.
	var viewport: Bounds? = nil // See Bounds for more information.
}


struct LatLngLiteral: Codable {
	
	var lat: Double? = nil // Latitude in decimal degrees
	var lng: Double? = nil // Longitude in decimal degrees
}


struct Bounds: Codable {
	
	var northeast: LatLngLiteral? = nil // See LatLngLiteral for         more information.
	var southwest: LatLngLiteral? = nil // See LatLngLiteral for         more information.
}


struct PlaceOpeningHours: Codable {
	
	var open_now: Bool? = nil // A boolean value indicating if the place is open at the current time.
	var periods: [PlaceOpeningHoursPeriod]? = nil // 
	var special_days: [PlaceSpecialDay]? = nil // 
	var type: String? = nil // 
	var weekday_text: [String]? = nil // An array of strings describing in human-readable text the hours of             the place.
}


struct PlaceOpeningHoursPeriod: Codable {
	
	var open: PlaceOpeningHoursPeriodDetail? = nil // 
	var close: PlaceOpeningHoursPeriodDetail? = nil // 
}


struct PlaceSpecialDay: Codable {
	
	var date: String? = nil // A date expressed in RFC3339 format in the local timezone for the             place, for example 2010-12-31.
	var exceptional_hours: Bool? = nil // 
}


struct PlaceOpeningHoursPeriodDetail: Codable {
	
	var day: Double? = nil // A number from 0–6, corresponding to the days of the week, starting             on Sunday. For example, 2 means Tuesday.
	var time: String? = nil // May contain a time of day in 24-hour hhmm format. Values are in the             range 0000–2359. The time will be reported in the place’s time zone.
	var date: String? = nil // A date expressed in RFC3339 format in the local timezone for the             place, for example 2010-12-31.
	var truncated: Bool? = nil // True if a given period was truncated due to a seven-day cutoff,             where the period starts before midnight on the date of the request             and/or ends at or after midnight on the last day. This property             indicates that the period for open or close can extend past this             seven-day cutoff.
}


struct PlacePhoto: Codable {
	
	var height: Double? = nil // The height of the photo.
	var html_attributions: [String]? = nil // The HTML attributions for the photo.
	var photo_reference: String? = nil // A string used to identify the photo when you perform a Photo             request.
	var width: Double? = nil // The width of the photo.
}


struct PlusCode: Codable {
	
	var global_code: String? = nil // 
	var compound_code: String? = nil // 
}


struct PlaceReview: Codable {
	
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


