//
//  DetailsViewHelper.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/12/20.
//

import UIKit
import MapKit

enum DetailsViewLabelGroup: String {
    case general, details
}

class DetailsViewHelper {
    static var shared = DetailsViewHelper()
    
    func prepareLabelText(from weather: WeatherObject, for labelGroup: DetailsViewLabelGroup) -> [String] {
        switch labelGroup {
        case .general:
            return [
                Helpers.shared.parseTemperature(from: weather.temperature),
                Helpers.shared.parseTemperature(from: weather.feelsLike),
                weather.date.format(),
                weather.location
            ]
        case .details:
            let windDirection = Helpers.shared.getWindDirection(from: weather.windDirection)
            return [
                String(weather.presure),
                String(weather.humidity),
                String(weather.windSpeed),
                windDirection ?? "–"
            ]
        }
    }
    
    func prepareLabelsContent(with text: [String], for labels: inout [UILabel]) {
        labels.enumerated().forEach { (index, element) in
            element.text = text[index]
        }
    }
    
    func getAnnotation(with weather: WeatherObject?, handler: @escaping (Annotation, CLLocationCoordinate2D) -> Void) {
        guard let weather = weather, let url = Helpers.shared.generateIconUrl(with: weather.image) else { return }
        
        let latitude = weather.coordinate.latitude
        let longitude = weather.coordinate.longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        do {
            let data = try Data(contentsOf: url)
            let annotation = Annotation(image: UIImage(data: data), coordinate: coordinate)
            handler(annotation, coordinate)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func transformOnScroll(with offset: CGPoint, and objectHeight: CGFloat) -> CATransform3D {
        if offset.y < 0.0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, (offset.y), 0)
            let scaleFactor = 1 + (-1 * offset.y / (objectHeight / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            return transform
        } else {
            return CATransform3DIdentity
        }
    }
}
