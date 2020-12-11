//
//  MainCoordinator.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/9/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = HomeViewController.instantiate()
        viewController.coordinator = self
        viewController.title = "Weather Logger"
        navigationController.pushViewController(viewController, animated: false)
    }
    
    func navigateToDetails(with weather: WeatherObject) {
        let viewController = DetailsViewController.instantiate()
        viewController.weather = weather
        navigationController.pushViewController(viewController, animated: true)
    }
}
