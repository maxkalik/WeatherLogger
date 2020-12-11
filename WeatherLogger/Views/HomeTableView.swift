//
//  HomeTableView.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import UIKit

class HomeTableView: UITableView {
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        register(nib, forCellReuseIdentifier: "TableViewCell")
        delegate = self
        dataSource = self
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
        //     //
        //     // let weather = weatherList[indexPath.row]
        //     //
        //     // let temperature = Helpers.shared.parseTemperature(from: weather.temperature)
        //     // cell.configure(image: weather.image, temperature: temperature, date: weather.date.format(), location: weather.location)
        //     cell.configure(image: nil, temperature: "20", date: "20", location: "Riga")
        //     cell.selectionStyle = .none
        //     return cell
        // }
        return UITableViewCell()
    }
}
