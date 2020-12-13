//
//  MainCoordinator.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/9/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    let persistenceManager: PersistenceManager
    
    init(navigationController: UINavigationController, persistenceManager: PersistenceManager) {
        self.navigationController = navigationController
        self.persistenceManager = persistenceManager
    }
    
    func start() {
        let viewController = HomeViewController.instantiate()
        viewController.coordinator = self
        viewController.persistenceManager = persistenceManager
        viewController.title = "Weather Logger"
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToDetails(with weather: WeatherData) {
        let viewController = DetailsViewController.instantiate()
        viewController.weather = weather
        navigationController.pushViewController(viewController, animated: true)
    }
}
