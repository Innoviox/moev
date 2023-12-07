import Foundation
struct PlacesAutocompleteResponse: Codable {
    
	var predictions: [PlaceAutocompletePrediction]? = nil // 
	var status: PlacesAutocompleteStatus? = nil // 
	var error_message: String? = nil // 
	var info_messages: [String]? = nil // 
}

extension PlacesAutocompleteResponse {
    static func from(jsonData data: Data) -> PlacesAutocompleteResponse? {
        return try? JSONDecoder().decode(PlacesAutocompleteResponse.self, from: data)
    }
}




struct PlaceAutocompletePrediction: Codable {
	
	var description: String? = nil // 
	var matched_substrings: [PlaceAutocompleteMatchedSubstring]? = nil // 
	var structured_formatting: PlaceAutocompleteStructuredFormat? = nil // 
	var terms: [PlaceAutocompleteTerm]? = nil // 
	var distance_meters: Int? = nil // 
	var place_id: String? = nil // 
	var reference: String? = nil // See place_id.
	var types: [String]? = nil // 
}


struct PlaceAutocompleteMatchedSubstring: Codable {
	
	var length: Double? = nil // Length of the matched substring in the prediction result text.
	var offset: Double? = nil // Start location of the matched substring in the prediction result             text.
}


struct PlaceAutocompleteStructuredFormat: Codable {
	
	var main_text: String? = nil // Contains the main text of a prediction, usually the name of the             place.
	var main_text_matched_substrings: [PlaceAutocompleteMatchedSubstring]? = nil // 
	var secondary_text: String? = nil // Contains the secondary text of a prediction, usually the location of             the place.
	var secondary_text_matched_substrings: [PlaceAutocompleteMatchedSubstring]? = nil // 
}


struct PlaceAutocompleteTerm: Codable {
	
	var offset: Double? = nil // Defines the start position of this term in the description, measured             in Unicode characters
	var value: String? = nil // The text of the term.
}


