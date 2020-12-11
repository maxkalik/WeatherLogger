//
//  Created by Maksim Kalik on 12/9/20.
//

// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

// Icons

// http://openweathermap.org/img/wn/10d@2x.png
// https://openweathermap.org/weather-conditions

import UIKit
import CoreLocation

class HomeViewController: UIViewController, Storyboarded, LocationManagerDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    weak var coordinator: MainCoordinator?

    private var tableViewDataSource: HomeTableViewDataSource?
    private var locationManager: LocationManager?
    private var progressView = ProgressView(title: "Fetching...")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(progressView)
        progressView.hide()
        tableViewDataSource = HomeTableViewDataSource(tableView: tableView)
        tableViewDataSource?.coordinator = coordinator
        locationManager = LocationManager()
        locationManager?.delegate = self
    }
    
    func didUpdateCurrentCoordinate(_ coordinate: Coordinate) {
        NetworkService.shared.fetchWeather(from: coordinate.latitude, longitude: coordinate.longitude) { [self] result in
            switch result {
            case .success(let data):
                let weather = WeatherObject(data: data, coordinate: coordinate)
                tableViewDataSource?.insertRow(with: weather)
                DispatchQueue.main.async {
                    progressView.hide()
                }
            case .failure(let error):
                print(error.localizedDescription)
                simpleAlert(title: "Error", msg: error.localizedDescription)
            }
        }
    }
    
    func didFailWithError(_ error: Error) {
        simpleAlert(title: "Error", msg: error.localizedDescription)
    }

    @IBAction func saveButtonTapped(_ sender: UIButton) {
        locationManager?.start()
        progressView.show()
    }
}
