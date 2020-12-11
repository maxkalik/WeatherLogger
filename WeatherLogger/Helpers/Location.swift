//
//  Location.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/10/20.
//

import CoreLocation

class Location {
    static func getLocation(from coordinate: CLLocationCoordinate2D?, complition: @escaping (Double, Double) -> Void) {
        guard let lat = coordinate?.latitude, let lon = coordinate?.longitude else { return }
        complition(lat, lon)
    }
}
