//
//  Created by Maksim Kalik on 12/9/20.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var tableView: UITableView!

    weak var coordinator: MainCoordinator?
    weak var persistenceManager: PersistenceManager?

    private var tableViewDataSource: HomeTableViewDataSource?
    private var locationManager: LocationManager?
    private var progressView = ProgressView(title: "Fetching...")
    
    var weatherList = [WeatherData]() {
        didSet {
            tableViewDataSource = HomeTableViewDataSource(tableView: tableView, dataList: weatherList.reversed(), withDelegate: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(progressView)
        progressView.hide()

        guard let persistenceManager = self.persistenceManager else { return }
        weatherList = PersistenceDataHelper.shared.getPersistentData(using: persistenceManager)
        
        locationManager = LocationManager()
        locationManager?.delegate = self
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        locationManager?.start()
        progressView.show()

    }
}

// MARK: - LocationManagerDelegate

extension HomeViewController: LocationManagerDelegate {
    func didUpdateCurrentCoordinate(_ coordinate: Coordinate) {
        NetworkService.shared.fetchWeather(from: coordinate.latitude, longitude: coordinate.longitude) { [self] result in
            switch result {
            case .success(let data):
                guard let persistentManager = self.persistenceManager else { return }
                let weather = PersistenceDataHelper.shared.createPersistentData(from: data, and: coordinate, using: persistentManager)
                tableViewDataSource?.insertRow(with: weather)
                DispatchQueue.main.async {
                    progressView.hide()
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async { [self] in
                    simpleAlert(title: "Internet connection failure", msg: "For using WeatherLogger, you need to have internet connection on in your iPhone.")
                    progressView.hide()
                }
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        simpleAlert(title: "Current location failure", msg: "For using WeatherLogger, please allow to find your current location. You can turn this on in your iPhone settings.")
        progressView.hide()
    }
}

// MARK: - ViewControllerDelegate

extension HomeViewController: ViewControllerDelegate {
    func didRemove(_ item: WeatherData) {
        guard let persistenceManager = self.persistenceManager else { return }
        persistenceManager.delete(item)
    }
    
    func didSelectRow(with object: WeatherData) {
        coordinator?.navigateToDetails(with: object)
    }
}
