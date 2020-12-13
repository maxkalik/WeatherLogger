//
//  WeatherResponse.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/9/20.
//

import Foundation

struct WeatherResponse: Codable {
    let main: Main
    let wind: Wind
    let weather: [Weather]
    let sys: Sys
    let name: String
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int16
    }
    
    struct Weather: Codable {
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let pressure: Int16
        let humidity: Int16
    }
    
    struct Sys: Codable {
        let country: String
    }
}
