//
//  TableViewDataSource.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import UIKit

class HomeTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    let tableView: UITableView
    var list = [WeatherObject]()
    
    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100.0
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            cell.configure(with: list[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func insertRow(with data: WeatherObject) {
        list.insert(data, at: 0)
        DispatchQueue.main.async { [self] in
            tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
        }
    }
    
    // func getWeather(from coordinate: Coordinate) {
    //     NetworkService.shared.fetchWeather(from: coordinate.latitude, longitude: coordinate.longitude) { [self] result in
    //         switch result {
    //         case .success(let data):
    //             let weather = WeatherObject(data: data, coordinate: coordinate)
    //             insertRow(with: weather)
    //         case .failure(let error):
    //             print(error.localizedDescription)
    //             // simpleAlert(title: "Error", msg: error.localizedDescription)
    //         }
    //     }
    // }

}
