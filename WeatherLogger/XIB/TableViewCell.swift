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
    }
    
    func configure(image: URL?, temperature: String, date: String, location: String) {
        guard let imageUrl = image else { return }
        weatherImageView.load(from: imageUrl)
        temperatureLabel.text = temperature
        dateLabel.text = date
        locationLabel.text = location
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
