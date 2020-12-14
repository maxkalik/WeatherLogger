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

final class DetailsViewHelper {
    static var shared = DetailsViewHelper()
    private init() {}
    
    func prepareLabelText(from weather: WeatherData, for labelGroup: DetailsViewLabelGroup) -> [String] {
        switch labelGroup {
        case .general:
            return [
                Parser.shared.parseTemperature(from: weather.temperature),
                Parser.shared.parseTemperature(from: weather.feelsLike),
                weather.date!.format(),
                weather.location ?? ""
            ]
        case .details:
            let windDirection = Parser.shared.getWindDirection(from: weather.windDirection)
            return [
                "\(weather.presure) hPa",
                "\(weather.humidity) %",
                "\(weather.windSpeed) m/s",
                windDirection ?? "–"
            ]
        }
    }
    
    func prepareLabelsContent(with text: [String], for labels: inout [UILabel]) {
        labels.enumerated().forEach { (index, element) in
            element.text = text[index]
        }
    }
    
    func getAnnotation(with weather: WeatherData?, handler: @escaping (Annotation, CLLocationCoordinate2D) -> Void) {
        guard let weather = weather,
              let imageUrlString = weather.image,
              let url = Parser.shared.generateIconUrl(with: imageUrlString) else { return }
        
        let latitude = weather.latitude
        let longitude = weather.longitude
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

        do {
            let data = try Data(contentsOf: url)
            let annotation = Annotation(image: UIImage(data: data), coordinate: coordinate)
            annotation.accessibilityLabel = "Annotation Pin"
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
