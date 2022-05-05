//
//  SearchViewController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit
import CoreLocation

class SearchViewController: UITableViewController, CLLocationManagerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    let locationManager = CLLocationManager()
    var viewModel: SearchTableViewViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setupSearchBar()
        viewModel = SearchTableViewViewModel()
        DispatchQueue.main.async { [unowned self] in
            self.viewModel?.fetchSavedCities(completion: {
                tableView.reloadData()
            })
        }
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.searchCellId)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.placeholder = "Поиск по городу (по-английски)"
    }
    
    //MARK: TableView Delegate&DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            guard let count = viewModel?.savedCities?.count else { return 0 }
            return count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Результат поиска"
        case 1:
            return "Текущее местоположение"
        case 2:
            return "Сохранённые города"
        default:
            return nil
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.searchCellId, for: indexPath) as! SearchTableViewCell
        switch indexPath.section {
        case 0:
            guard let searchResult = viewModel?.searchResult else {
                let defaultCell = UITableViewCell()
                defaultCell.textLabel?.text = "Введите условия поиска на английском языке"
                defaultCell.textLabel?.numberOfLines = 2
                return defaultCell
            }
            configureCell(cell: cell, with: searchResult)
        case 1:
            guard let currentLocation = viewModel?.currentLocation else {
                let defaultCell = UITableViewCell()
                defaultCell.textLabel?.numberOfLines = 2
                defaultCell.textLabel?.text = "У приложения нет данных о вашем местоположении"
                return defaultCell
            }
            DispatchQueue.main.async { [unowned self] in
                self.viewModel?.fetchLocationData(location: currentLocation as! LocationCoordinates, completion: { [unowned self] (result) in
                    self.configureCell(cell: cell, with: result)
                })
            }
        case 2:
            guard let city = viewModel?.savedCities?[indexPath.row] else {
                return cell
            }
            configureCell(cell: cell, with: city)
        default: break
        }
        return cell
    }
    
    private func configureCell(cell: SearchTableViewCell, with model: SearchDataModel) {
        cell.cityLabel.text = model.cityName
        cell.tempLabel.text = model.tempString
        cell.weatherIcon.image = WeatherIcons.getWeatherIcon(for: model.weatherCode)
        cell.latitude = model.latitude
        cell.longitude = model.longitude
    }
    //TODO: Pass coordinates to WeatherVC
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabVC = self.tabBarController else { return }
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier == SearchTableViewCell.searchCellId {
            guard let cell = cell as? SearchTableViewCell,
                  let lat = cell.latitude,
                  let lon = cell.longitude else { return }
            var coords = [String: Double]()
            coords["lat"] = lat
            coords["lon"] = lon
            NotificationCenter.default.post(name: Notification.Name(rawValue: "changeCoordinates"), object: nil, userInfo: coords)
            tabVC.selectedIndex = 0
        }
    }
    //MARK: - Swipe Actions
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0, 1:
            return nil
        case 2:
            let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
            let deleteAction = UIContextualAction(style: .destructive, title: deleteActionTitle) { [unowned self] _, _, completion in
                viewModel?.deleteCoordinates(from: indexPath) {
                    tableView.reloadData()
                }
                completion(false)
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        switch indexPath.section {
        case 0, 1:
            let saveActionTitle = NSLocalizedString("Save", comment: "Save action title")
            let saveAction = UIContextualAction(style: .normal, title: saveActionTitle) { [unowned self] _, _, completion in
                let cell = tableView.cellForRow(at: indexPath)
                if cell?.reuseIdentifier == SearchTableViewCell.searchCellId {
                    guard let cell = cell as? SearchTableViewCell,
                          let lat = cell.latitude,
                          let lon = cell.longitude else { return }
                    print("\(lat) \(lon)")
                    viewModel?.saveCoordinates(latitude: lat , longitude: lon, completion: {
                        tableView.reloadData()
                    })
                }
                completion(false)
            }
            saveAction.backgroundColor = .systemGreen
            return UISwipeActionsConfiguration(actions: [saveAction])
        case 2:
            return nil
        default:
            return nil
        }
    }
}
//MARK: Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [unowned self] (_) in
            self.viewModel?.fetchSearchData(searchText: searchText, completion: { [unowned self] in
                self.tableView.reloadData()
            })
        })
    }
}
//MARK: Location Manager Delegate
extension SearchViewController {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        viewModel?.currentLocation = LocationCoordinates(latitude: locValue.latitude, longitude: locValue.longitude)
        tableView.reloadData()
    }
}

