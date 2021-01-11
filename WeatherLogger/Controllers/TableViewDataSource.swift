//
//  TableViewDataSource.swift
//  WeatherLogger
//
//  Created by Maksim Kalik on 12/11/20.
//

import UIKit

protocol ViewControllerDelegate: class {
    func didRemove(_ item: WeatherData)
    func didSelectRow(with: WeatherData)
}

class HomeTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {

    let tableView: UITableView
    weak var delegate: ViewControllerDelegate?
    var dataList: [WeatherData]

    init(tableView: UITableView, dataList: [WeatherData], withDelegate delegate: ViewControllerDelegate) {
        self.tableView = tableView
        self.dataList = dataList
        self.delegate = delegate
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
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell {
            cell.configure(with: dataList[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }

    func insertRow(with data: WeatherData) {
        dataList.insert(data, at: 0)
        DispatchQueue.main.async { [self] in
            tableView.insertRows(at: [IndexPath(item: 0, section: 0)], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectRow(with: dataList[indexPath.row])
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextAction = UIContextualAction(style: .normal, title: "Delete") { (_, _, success) in
            success(true)
        }
        contextAction.backgroundColor = .black
        contextAction.title = ""
        contextAction.image = UIImage(named: "icon_trash_circle")
        return UISwipeActionsConfiguration(actions: [contextAction])
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            delegate?.didRemove(dataList[indexPath.row])
            dataList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
