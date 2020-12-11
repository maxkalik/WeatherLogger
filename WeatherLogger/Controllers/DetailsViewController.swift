import UIKit
import MapKit

extension MKMapView {
    func fitAnnotations(inset: CGFloat) {
        var zoomRect = MKMapRect.null;
        for annotation in annotations {
            let annotationPoint = MKMapPoint(annotation.coordinate)
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0.01, height: 0.01);
            zoomRect = zoomRect.union(pointRect);
        }
        setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset), animated: true)
    }
}

class DetailsViewController: UIViewController, Storyboarded {
    
    
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.contentInsetAdjustmentBehavior = .never
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            mapView.contentMode = .scaleAspectFit
            mapView.layoutMargins.bottom = -100
            mapView.isZoomEnabled = false
            mapView.isScrollEnabled = false
            mapView.isUserInteractionEnabled = false
            mapView.showsCompass = false
            
        }
    }
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var presureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDirectionLabel: UILabel!
    
    var weather: WeatherObject?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let weather = self.weather else { return }
        temperatureLabel.text = Helpers.shared.parseTemperature(from: weather.temperature)
        temperatureLabel.text = Helpers.shared.parseTemperature(from: weather.temperature)
        feelsLikeLabel.text = String(weather.feelsLike)
        dateLabel.text = weather.date.format()
        locationLabel.text = weather.location
        
        presureLabel.text = String(weather.presure)
        humidityLabel.text = String(weather.humidity)
        windSpeedLabel.text = String(weather.windSpeed)
        windDirectionLabel.text = String(weather.windDirection)
        
        configureMap()
    }
    
    func configureMap() {
        guard let latitude = weather?.coordinate.latitude, let longitude = weather?.coordinate.longitude else { return }
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.setCenter(coordinate, animated: true)
        mapView.addAnnotation(annotation)
    }
}

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset

        if offset.y < 0.0 {
            var transform = CATransform3DTranslate(CATransform3DIdentity, 0, (offset.y), 0)
            let scaleFactor = 1 + (-1 * offset.y / (mapView.frame.size.height / 2))
            transform = CATransform3DScale(transform, scaleFactor, scaleFactor, 1)
            mapView.layer.transform = transform
        } else {
            mapView.layer.transform = CATransform3DIdentity
        }
    }
}
