import UIKit
import MapKit

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
            mapView.showsCompass = false
            mapView.subviews[1].removeFromSuperview()
            mapView.register(AnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        }
    }
    
    @IBOutlet var generalLabels: [UILabel]!
    @IBOutlet var detailsLabels: [UILabel]!
    
    var weather: WeatherObject?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLabels()
        DetailsViewHelper.shared.getAnnotation(with: weather) {(annotation, coordinate) in
            self.mapView.setCenter(coordinate, animated: true)
            self.mapView.addAnnotation(annotation)
        }
    }
    
    func setupLabels() {
        guard let weather = self.weather else { return }
        let generalLabelText = DetailsViewHelper.shared.prepareLabelText(from: weather, for: .general)
        let detailsLabelText = DetailsViewHelper.shared.prepareLabelText(from: weather, for: .details)
        DetailsViewHelper.shared.prepareLabelsContent(with: generalLabelText, for: &generalLabels)
        DetailsViewHelper.shared.prepareLabelsContent(with: detailsLabelText, for: &detailsLabels)
    }
}


// MARK: - UIScrollViewDelegate

extension DetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let transform = DetailsViewHelper.shared.transformOnScroll(with: scrollView.contentOffset, and: mapView.frame.size.height)
        mapView.layer.transform = transform
    }
}
