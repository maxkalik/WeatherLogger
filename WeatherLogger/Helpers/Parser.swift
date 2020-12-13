//
//  Helpers.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import UIKit
import MapKit

final class Parser {
    static var shared = Parser()
    private init() {}
    
    func generateIconUrl(with name: String) -> URL? {
        return URL(string: "http://openweathermap.org/img/wn/\(name)@2x.png")
    }
    
    func parseTemperature(from kelvin: Double) -> String {
        let temperature = String(format: "%.0f", kelvin - 273.15)
        return "\(temperature) Cº"
    }
    
    func getWindDirection(from degree: Int16) -> String? {
        if degree < 0 { return nil }

        let directions = ["⬆️", "↗️", "➡️", "↘️", "⬇️", "↙️", "⬅️", "↖️"]
        let index = Int((Double(degree) + 22.5) / 45.0) & 7
        return directions[index]
    }
}
