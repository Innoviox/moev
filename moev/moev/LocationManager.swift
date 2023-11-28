//
//  LocationManager.swift
//  moev
//
//  Created by Simon Chervenak on 11/28/23.
//

// https://stackoverflow.com/questions/57681885/how-to-get-current-location-using-swiftui-without-viewcontrollers
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-read-the-users-location-using-locationbutton
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    @Published var location: CLLocationCoordinate2D?
    
    var updateHandler: (CLLocationCoordinate2D) -> Void = { i in }

    init(handler: @escaping (CLLocationCoordinate2D) -> Void) {
        super.init()
        manager.delegate = self
        
        updateHandler = handler
    }

    func requestLocation() {
        manager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        updateHandler(location!)
    }
}
