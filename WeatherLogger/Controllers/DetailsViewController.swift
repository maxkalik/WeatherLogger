import UIKit

class DetailsViewController: UIViewController, Storyboarded {
    
    var weather: WeatherObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("details view controller", weather)
    }
}
