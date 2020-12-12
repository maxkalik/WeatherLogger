//
//  WeatherData+CoreDataProperties.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/13/20.
//
//

import Foundation
import CoreData


extension WeatherData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherData> {
        return NSFetchRequest<WeatherData>(entityName: "WeatherData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var feelsLike: NSDecimalNumber?
    @NSManaged public var humidity: Int16
    @NSManaged public var image: String?
    @NSManaged public var latitude: Double
    @NSManaged public var location: String?
    @NSManaged public var longitude: Double
    @NSManaged public var presure: Int16
    @NSManaged public var temperature: Double
    @NSManaged public var windDirection: Int16
    @NSManaged public var windSpeed: Double

}

extension WeatherData : Identifiable {

}
