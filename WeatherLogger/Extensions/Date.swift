//
//  Date.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import Foundation

extension Date {
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMM YYYY"
        let today = dateFormatter.string(from: self)
        return today
    }
}
