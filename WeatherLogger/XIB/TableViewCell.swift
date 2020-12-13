//
//  TableViewCell.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/10/20.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }
    
    func configure(with object: WeatherData?) {
        guard let weather = object else { return }
        
        temperatureLabel.text = Parser.shared.parseTemperature(from: weather.temperature)
        dateLabel.text = weather.date?.format()
        locationLabel.text = weather.location
        
        guard let imageUrlString = weather.image, let image = Parser.shared.generateIconUrl(with: imageUrlString) else { return }
        weatherImageView.load(from: image)
    }
}
