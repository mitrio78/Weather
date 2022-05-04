//
//  SearchViewController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit
import Alamofire
import CoreLocation

struct LocationCoordinates: LocationCoordinatesProtocol {
    var latitude: CLLocationDegrees
    var longitude: CLLocationDegrees
}

class SearchViewController: UITableViewController, CLLocationManagerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    let locationManager = CLLocationManager()
    var viewModel: SearchTableViewViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        setupSearchBar()
        viewModel = SearchTableViewViewModel()
        viewModel?.fetchSavedCities()

        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.searchCellId)
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
                defaultCell.textLabel?.text = "Введите условия поиска..."
                return defaultCell
            }
            configureCell(cell: cell, with: searchResult, buttonHidden: false)
        case 1:
            guard let currentLocation = viewModel?.currentLocation else {
                let defaultCell = UITableViewCell()
                defaultCell.textLabel?.numberOfLines = 2
                defaultCell.textLabel?.text = "У приложения нет данных о вашем местоположении"
                return defaultCell
            }
            viewModel?.fetchLocationData(location: currentLocation as! LocationCoordinates, completion: { [unowned self] (result) in
                self.configureCell(cell: cell, with: result, buttonHidden: false)
            })
        case 2:
            guard let city = viewModel?.savedCities?[indexPath.row] else {
                return cell
            }
            configureCell(cell: cell, with: city, buttonHidden: true)
        default: break
        }
        return cell
    }
    
    private func configureCell(cell: SearchTableViewCell, with model: SearchDataModel, buttonHidden checkBox: Bool) {
        cell.addButton.isHidden = checkBox
        cell.cityLabel.text = model.cityName
        cell.tempLabel.text = model.tempString
        cell.weatherIcon.image = WeatherIcons.getWeatherIcon(for: model.weatherCode)
        cell.latitude = model.latitude
        cell.longitude = model.longitude
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabVC = self.tabBarController else { return }
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier == SearchTableViewCell.searchCellId {
            guard let cell = cell as? SearchTableViewCell,
                    let lat = cell.latitude,
                  let lon = cell.longitude else {
                return
            }
            print("\(lat) : \(lon)")
            tabVC.selectedIndex = 0
        }
        //TODO: pass data to WVC
    }
}
//MARK: Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [unowned self] (_) in
            self.viewModel?.fetchSearchData(searchText: searchText, completion: {
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
