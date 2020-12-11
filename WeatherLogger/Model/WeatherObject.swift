//
//  WeatherObject.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import Foundation

struct WeatherObject {
    let temperature: Double
    let feelsLike: Double
    let date: Date
    let location: String
    let presure: Int
    let humidity: Int
    let windSpeed: Double
    let windDirection: Int
    let image: String
    let coordinate: Coordinate
    
    init(data: WeatherResponse, coordinate: Coordinate) {
        temperature = data.main.temp
        feelsLike = data.main.feelsLike
        date = Date()
        location = "\(data.name), \(data.sys.country)"
        presure = data.main.pressure
        humidity = data.main.humidity
        windSpeed = data.wind.speed
        windDirection = data.wind.deg
        image = data.weather[0].icon
        self.coordinate = coordinate
    }
}
