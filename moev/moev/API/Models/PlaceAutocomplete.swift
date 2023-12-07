import Foundation
struct PlacesAutocompleteResponse: Codable, Identifiable {
	var id = UUID()
	var predictions: [PlaceAutocompletePrediction]? = nil // 
	var status: PlacesAutocompleteStatus? = nil // 
	var error_message: String? = nil // 
	var info_messages: [String]? = nil // 
}

extension PlacesAutocompleteResponse {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		predictions = (json["predictions"] as? [[String: Any]] ?? nil)?.map { j in PlaceAutocompletePrediction(json: j) }
		

		if let jstatus = json["status"] as? String {
			status = PlacesAutocompleteStatus(rawValue: jstatus)!
		}

		if let jerror_message = json["error_message"] as? String {
			error_message = jerror_message
		}

		info_messages = (json["info_messages"] as? [String] ?? nil)?.map { j in j }
		
	}
}
extension PlacesAutocompleteResponse {
	static func from(jsonData data: Data) -> PlacesAutocompleteResponse? {
		let data = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
		return PlacesAutocompleteResponse(json: data)
	}
}



struct PlaceAutocompletePrediction: Codable, Identifiable {
	var id = UUID()
	var description: String? = nil // 
	var matched_substrings: [PlaceAutocompleteMatchedSubstring]? = nil // 
	var structured_formatting: PlaceAutocompleteStructuredFormat? = nil // 
	var terms: [PlaceAutocompleteTerm]? = nil // 
	var distance_meters: Int? = nil // 
	var place_id: String? = nil // 
	var reference: String? = nil // See place_id.
	var types: [String]? = nil // 
}

extension PlaceAutocompletePrediction {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jdescription = json["description"] as? String {
			description = jdescription
		}

		matched_substrings = (json["matched_substrings"] as? [[String: Any]] ?? nil)?.map { j in PlaceAutocompleteMatchedSubstring(json: j) }
		

		if let jstructured_formatting = json["structured_formatting"] as? [String: Any] {
			structured_formatting = PlaceAutocompleteStructuredFormat(json: jstructured_formatting)
		}

		terms = (json["terms"] as? [[String: Any]] ?? nil)?.map { j in PlaceAutocompleteTerm(json: j) }
		

		if let jdistance_meters = json["distance_meters"] as? Int {
			distance_meters = jdistance_meters
		}

		if let jplace_id = json["place_id"] as? String {
			place_id = jplace_id
		}

		if let jreference = json["reference"] as? String {
			reference = jreference
		}

		types = (json["types"] as? [String] ?? nil)?.map { j in j }
		
	}
}

struct PlaceAutocompleteMatchedSubstring: Codable, Identifiable {
	var id = UUID()
	var length: Double? = nil // Length of the matched substring in the prediction result text.
	var offset: Double? = nil // Start location of the matched substring in the prediction result             text.
}

extension PlaceAutocompleteMatchedSubstring {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jlength = json["length"] as? Double {
			length = jlength
		}

		if let joffset = json["offset"] as? Double {
			offset = joffset
		}
	}
}

struct PlaceAutocompleteStructuredFormat: Codable, Identifiable {
	var id = UUID()
	var main_text: String? = nil // Contains the main text of a prediction, usually the name of the             place.
	var main_text_matched_substrings: [PlaceAutocompleteMatchedSubstring]? = nil // 
	var secondary_text: String? = nil // Contains the secondary text of a prediction, usually the location of             the place.
	var secondary_text_matched_substrings: [PlaceAutocompleteMatchedSubstring]? = nil // 
}

extension PlaceAutocompleteStructuredFormat {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let jmain_text = json["main_text"] as? String {
			main_text = jmain_text
		}

		main_text_matched_substrings = (json["main_text_matched_substrings"] as? [[String: Any]] ?? nil)?.map { j in PlaceAutocompleteMatchedSubstring(json: j) }
		

		if let jsecondary_text = json["secondary_text"] as? String {
			secondary_text = jsecondary_text
		}

		secondary_text_matched_substrings = (json["secondary_text_matched_substrings"] as? [[String: Any]] ?? nil)?.map { j in PlaceAutocompleteMatchedSubstring(json: j) }
		
	}
}

struct PlaceAutocompleteTerm: Codable, Identifiable {
	var id = UUID()
	var offset: Double? = nil // Defines the start position of this term in the description, measured             in Unicode characters
	var value: String? = nil // The text of the term.
}

extension PlaceAutocompleteTerm {
	init(json jsonOrNil: [String: Any]?) {
		guard let json = jsonOrNil else {
			return
		}

		if let joffset = json["offset"] as? Double {
			offset = joffset
		}

		if let jvalue = json["value"] as? String {
			value = jvalue
		}
	}
}

