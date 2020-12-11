import UIKit
import MapKit

enum DetailsViewLabelGroup: String {
    case general, details
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
    
    @IBOutlet var generalLabels: [UILabel]!
    @IBOutlet var detailsLabels: [UILabel]!
    
    var weather: WeatherObject?
    
    func setupLabels() {
        guard let weather = self.weather else { return }
        let generalLabelText = Helpers.shared.prepareLabelText(from: weather, for: .general)
        let detailsLabelText = Helpers.shared.prepareLabelText(from: weather, for: .details)
        Helpers.shared.prepareLabelsContent(with: generalLabelText, for: &generalLabels)
        Helpers.shared.prepareLabelsContent(with: detailsLabelText, for: &detailsLabels)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLabels()
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
        let transform = Helpers.shared.transformOnScroll(with: scrollView.contentOffset, and: mapView.frame.size.height)
        mapView.layer.transform = transform
    }
}
