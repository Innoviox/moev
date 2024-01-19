import Foundation
struct PlacesAutocompleteResponse: Codable, Identifiable {
	var id = UUID()
	var predictions: [PlaceAutocompletePrediction]? = nil // 
	var status: PlacesAutocompleteStatus? = nil // 
	var error_message: String? = nil // 
	var info_messages: [String]? = nil // 
}

extension PlacesAutocompleteResponse {
	enum CodingKeys: String, CodingKey {
		case predictions
		case status
		case error_message
		case info_messages
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		predictions = try container.decodeIfPresent([PlaceAutocompletePrediction].self, forKey: .predictions)
		status = try container.decodeIfPresent(PlacesAutocompleteStatus.self, forKey: .status)
		error_message = try container.decodeIfPresent(String.self, forKey: .error_message)
		info_messages = try container.decodeIfPresent([String].self, forKey: .info_messages)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(predictions, forKey: .predictions)
		try container.encodeIfPresent(status, forKey: .status)
		try container.encodeIfPresent(error_message, forKey: .error_message)
		try container.encodeIfPresent(info_messages, forKey: .info_messages)
	}
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
	enum CodingKeys: String, CodingKey {
		case description
		case matched_substrings
		case structured_formatting
		case terms
		case distance_meters
		case place_id
		case reference
		case types
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		description = try container.decodeIfPresent(String.self, forKey: .description)
		matched_substrings = try container.decodeIfPresent([PlaceAutocompleteMatchedSubstring].self, forKey: .matched_substrings)
		structured_formatting = try container.decodeIfPresent(PlaceAutocompleteStructuredFormat.self, forKey: .structured_formatting)
		terms = try container.decodeIfPresent([PlaceAutocompleteTerm].self, forKey: .terms)
		distance_meters = try container.decodeIfPresent(Int.self, forKey: .distance_meters)
		place_id = try container.decodeIfPresent(String.self, forKey: .place_id)
		reference = try container.decodeIfPresent(String.self, forKey: .reference)
		types = try container.decodeIfPresent([String].self, forKey: .types)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(description, forKey: .description)
		try container.encodeIfPresent(matched_substrings, forKey: .matched_substrings)
		try container.encodeIfPresent(structured_formatting, forKey: .structured_formatting)
		try container.encodeIfPresent(terms, forKey: .terms)
		try container.encodeIfPresent(distance_meters, forKey: .distance_meters)
		try container.encodeIfPresent(place_id, forKey: .place_id)
		try container.encodeIfPresent(reference, forKey: .reference)
		try container.encodeIfPresent(types, forKey: .types)
	}
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
	enum CodingKeys: String, CodingKey {
		case length
		case offset
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		length = try container.decodeIfPresent(Double.self, forKey: .length)
		offset = try container.decodeIfPresent(Double.self, forKey: .offset)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(length, forKey: .length)
		try container.encodeIfPresent(offset, forKey: .offset)
	}
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
	enum CodingKeys: String, CodingKey {
		case main_text
		case main_text_matched_substrings
		case secondary_text
		case secondary_text_matched_substrings
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		main_text = try container.decodeIfPresent(String.self, forKey: .main_text)
		main_text_matched_substrings = try container.decodeIfPresent([PlaceAutocompleteMatchedSubstring].self, forKey: .main_text_matched_substrings)
		secondary_text = try container.decodeIfPresent(String.self, forKey: .secondary_text)
		secondary_text_matched_substrings = try container.decodeIfPresent([PlaceAutocompleteMatchedSubstring].self, forKey: .secondary_text_matched_substrings)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(main_text, forKey: .main_text)
		try container.encodeIfPresent(main_text_matched_substrings, forKey: .main_text_matched_substrings)
		try container.encodeIfPresent(secondary_text, forKey: .secondary_text)
		try container.encodeIfPresent(secondary_text_matched_substrings, forKey: .secondary_text_matched_substrings)
	}
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
	enum CodingKeys: String, CodingKey {
		case offset
		case value
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		offset = try container.decodeIfPresent(Double.self, forKey: .offset)
		value = try container.decodeIfPresent(String.self, forKey: .value)
	}

	func encode(to encoder: Encoder) throws {
		var container = encoder.container(keyedBy: CodingKeys.self)

		try container.encodeIfPresent(offset, forKey: .offset)
		try container.encodeIfPresent(value, forKey: .value)
	}
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

