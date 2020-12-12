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
    var coordinator: MainCoordinator?

    init(tableView: UITableView) {
        self.tableView = tableView
        super.init()

        let nib = UINib(nibName: "TableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TableViewCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100.0
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        tableView.contentInset = insets
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.navigateToDetails(with: list[indexPath.row])
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
