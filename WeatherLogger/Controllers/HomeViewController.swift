//
//  Created by Maksim Kalik on 12/9/20.
//

// api.openweathermap.org/data/2.5/weather?lat={lat}&lon={lon}&appid={API key}

// Icons

// http://openweathermap.org/img/wn/10d@2x.png
// https://openweathermap.org/weather-conditions

import UIKit
import CoreLocation

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
    
    private var pogressView = ProgressView(title: "Fetching...")
    
    var currentCoordinate: Coordinate? {
        didSet {
            getWeather()
        }
    }
    
    private var locationManger: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManger = CLLocationManager()
        locationManger?.delegate = self
        
        view.addSubview(pogressView)
        pogressView.hide()
    }
    
    func getWeather() {
        guard let currentCoordinate = self.currentCoordinate else { return }
        NetworkService.shared.fetchWeather(from: currentCoordinate.latitude, longitude: currentCoordinate.longitude) { [self] result in
            switch result {
            case .success(let data):
                
                guard let img = Helpers.shared.generateIconUrl(with: data.weather[0].icon) else { return }
                let location = "\(data.name), \(data.sys.country)"
                
                let weather = WeatherObject(temperature: data.main.temp, feelsLike: data.main.feelsLike, date: Date(), location: location, presure: data.main.pressure, humidity: data.main.humidity, windSpeed: data.wind.speed, windDirection: "NW", image: img, coordinate: currentCoordinate)
                
                weatherList.insert(weather, at: 0)
                DispatchQueue.main.async {
                    self.pogressView.hide()
                    self.tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        currentCoordinate = nil // update
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
        locationManger?.requestAlwaysAuthorization()
        locationManger?.startUpdatingLocation()
        pogressView.show()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManger?.stopUpdatingLocation()
            
            if self.currentCoordinate == nil {
                self.currentCoordinate = Coordinate(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
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
            
            let temperature = Helpers.shared.parseTemperature(from: weather.temperature)
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
