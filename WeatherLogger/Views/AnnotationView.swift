//
//  AnnotationView.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/12/20.
//

import MapKit

class AnnotationView: MKAnnotationView {
    private var pinImage = UIImage()
    override var annotation: MKAnnotation? {
        willSet {
            guard let annotation = newValue as? Annotation else { return }
            image = annotation.image
        }
    }
}
