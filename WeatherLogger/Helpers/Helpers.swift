//
//  Helpers.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import UIKit
import MapKit

class Helpers {
    static var shared = Helpers()
    
    func generateIconUrl(with name: String) -> URL? {
        return URL(string: "http://openweathermap.org/img/wn/\(name)@2x.png")
    }
    
    func parseTemperature(from kelvin: Double) -> String {
        let temperature = String(format: "%.0f", kelvin - 273.15)
        return "\(temperature) Cº"
    }
}
