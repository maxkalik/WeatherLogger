//
//  Created by Maksim Kalik on 12/9/20.
//

// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

// Icons

// http://openweathermap.org/img/wn/10d@2x.png
// https://openweathermap.org/weather-conditions

import UIKit
import CoreLocation

struct CurrentLocation: Equatable {
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}

class HomeViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            print("table view set")
            let nib = UINib(nibName: "TableViewCell", bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
        }
    }
    
    weak var coordinator: MainCoordinator?
    var weatherList = [WeatherObject]()
    // var currentWeather: WeatherObject?
    
    var currentLocation: CurrentLocation? {
        didSet {
            getWeather()
        }
    }
    
    private var locationManger: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger = CLLocationManager()
        locationManger?.delegate = self
    }
    
    func getWeather() {
        guard let currentLocation = self.currentLocation else { return }
        NetworkService.shared.fetchWeather(from: currentLocation.latitude, longitude: currentLocation.longitude) { [self] result in
            switch result {
            case .success(let data):
                
                let imgURL = URL(string: "http://openweathermap.org/img/wn/\(data.weather[0].icon)@2x.png")
                guard let img = imgURL else { return }
                
                let location = "\(data.name), \(data.sys.country)"
                
                let weather = WeatherObject(temperature: data.main.temp, feelsLike: data.main.feelsLike, date: Date(), location: location, presure: data.main.pressure, humidity: data.main.humidity, windSpeed: data.wind.speed, windDirection: "NW", image: img)
                
                weatherList.insert(weather, at: 0)
                DispatchQueue.main.async {
                    self.tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        currentLocation = nil // update
        startGetingLocation()
    }
}

extension Date {
    func format() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm, dd MMM YYYY"
        let today = dateFormatter.string(from: self)
        return today
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    private func startGetingLocation() {
        print("start getting location")
        locationManger?.requestAlwaysAuthorization()
        locationManger?.startUpdatingLocation()
        
        // locationManger?.desiredAccuracy = kCLLocationAccuracyBest
        // locationManger?.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManger?.stopUpdatingLocation()
            
            if self.currentLocation == nil {
                self.currentLocation = CurrentLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            let weather = weatherList[indexPath.row]
            let temperature = String(format: "%.0f", weather.temperature - 273.15)
            cell.configure(image: weather.image, temperature: temperature, date: weather.date.format(), location: weather.location)
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // print(weatherList[indexPath.row])
        coordinator?.navigateToDetails(with: weatherList[indexPath.row])
    }
}
