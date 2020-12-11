//
//  Helpers.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import UIKit

class Helpers {
    static var shared = Helpers()
    
    func generateIconUrl(with name: String) -> URL? {
        return URL(string: "http://openweathermap.org/img/wn/\(name)@2x.png")
    }
    
    func parseTemperature(from kelvin: Double) -> String {
        let temperature = String(format: "%.0f", kelvin - 273.15)
        return "\(temperature) Cº"
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
            return [
                String(weather.presure),
                String(weather.humidity),
                String(weather.windSpeed),
                String(weather.windDirection)
            ]
        }
    }
    
    func prepareLabelsContent(with text: [String], for labels: inout [UILabel]) {
        labels.enumerated().forEach { (index, element) in
            element.text = text[index]
        }
    }
}
