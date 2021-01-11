//
//  Location.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/10/20.
//

import CoreLocation

protocol LocationManagerDelegate: HomeViewController {
    func didUpdateCurrentCoordinate(_ coordinate: Coordinate)
    func didFailWithError(_ error: Error)
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    let locationManager: CLLocationManager?
    var currentCoordinate: Coordinate? {
        didSet {
            guard let coordinate = currentCoordinate else { return }
            delegate?.didUpdateCurrentCoordinate(coordinate)
        }
    }
    
    weak var delegate: LocationManagerDelegate?
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        locationManager?.delegate = self
    }
    
    func start() {
        if currentCoordinate != nil {
            currentCoordinate = nil
        }
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        // locationManager?.requestLocation() // << once but too long 10 sec
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
  
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            if currentCoordinate == nil {
                currentCoordinate = Coordinate(latitude: latitude, longitude: longitude)
            } else {
                locationManager?.stopUpdatingLocation()
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager?.stopUpdatingLocation()
        delegate?.didFailWithError(error)
    }
}

