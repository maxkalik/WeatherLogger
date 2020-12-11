//
//  File.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/9/20.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
