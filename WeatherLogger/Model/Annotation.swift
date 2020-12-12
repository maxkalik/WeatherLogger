//
//  Annotation.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/12/20.
//

import MapKit

class Annotation: NSObject, MKAnnotation {
    let image: UIImage?
    let coordinate: CLLocationCoordinate2D
    
    init(image: UIImage?, coordinate: CLLocationCoordinate2D) {
        self.image = image
        self.coordinate = coordinate
        super.init()
    }
}
