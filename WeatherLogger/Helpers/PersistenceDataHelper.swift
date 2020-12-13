//
//  PersistenceDataHelper.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/13/20.
//

import Foundation

class PersistenceDataHelper {
    static let shared = PersistenceDataHelper()
    private init() {}
    
    func getPersistentData(using persistenceManager: PersistenceManager) -> [WeatherData] {
        let weatherList = persistenceManager.fetch(WeatherData.self)
        return weatherList
    }
    
    func createPersistentData(from data: WeatherResponse, and coordinate: Coordinate, using persistenceManager: PersistenceManager) -> WeatherData {
        let weather = WeatherData(context: persistenceManager.context)
        
        // I know this bad practice
        weather.id = UUID().uuidString
        weather.temperature = data.main.temp
        weather.feelsLike = data.main.feelsLike
        weather.date = Date()
        weather.location = "\(data.name), \(data.sys.country)"
        weather.presure = data.main.pressure
        weather.humidity = data.main.humidity
        weather.windSpeed = data.wind.speed
        weather.windDirection = data.wind.deg
        weather.image = data.weather[0].icon
        weather.latitude = coordinate.latitude
        weather.longitude = coordinate.longitude
        
        persistenceManager.saveContext()
        
        return weather
    }
}
