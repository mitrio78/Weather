//
//  SearchViewController.swift
//  Weather
//
//  Created by Mitrio on 14.04.2022.
//

import UIKit
import CoreLocation

final class SearchViewController: UITableViewController, CLLocationManagerDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    private var timer: Timer?
    let locationManager = CLLocationManager()
    var viewModel: SearchTableViewViewModelProtocol?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        viewModel = SearchTableViewViewModel()
        requestLocation()
        setupSearchBar()
        self.viewModel?.fetchSavedCities(completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: String(describing: SearchTableViewCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.searchCellId)
    }
    
    private func requestLocation() {
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
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
            return viewModel?.savedCities?.count ?? 0
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
        
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        switch indexPath.section {
        case 0:
            guard let searchResult = viewModel.searchResult else {
                let defaultCell = UITableViewCell()
                defaultCell.textLabel?.text = "Введите условия поиска на английском языке"
                defaultCell.textLabel?.numberOfLines = 2
                return defaultCell
            }
            cell.configureCell(with: searchResult)
            return cell

        case 1:
            guard let currentLocation = viewModel.currentLocation else {
                let defaultCell = UITableViewCell()
                defaultCell.textLabel?.numberOfLines = 2
                defaultCell.textLabel?.text = "Нет данных о вашем местоположении"
                return defaultCell
            }
            self.viewModel?.fetchLocationData(
                location: currentLocation as! LocationCoordinates,
                completion: { (result) in
                cell.configureCell(with: result)
            })
            return cell
        case 2:
            guard let city = viewModel.savedCities?[indexPath.row] else { return UITableViewCell() }
            cell.configureCell(with: city)
            return cell
        default: return UITableViewCell()
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let tabVC = self.tabBarController else { return }
            guard let cell = getCell(for: indexPath),
                  let lat = cell.viewModel?.latitude,
                  let lon = cell.viewModel?.longitude else { return }
        var coords = [String: Double]()
        coords["lat"] = lat
        coords["lon"] = lon
        NotificationCenter.default.post(
            name: Notification.Name(rawValue: "changeCoordinates"),
            object: nil,
            userInfo: coords
        )
        tabVC.selectedIndex = 0
    }
    //MARK: - Swipe Actions
    override func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0, 1:
            return nil
        case 2:
            let deleteActionTitle = NSLocalizedString("Delete", comment: "Delete action title")
            let deleteAction = UIContextualAction(
                style: .destructive,
                title: deleteActionTitle
            ) { [weak self] _, _, completion in
                guard let coordinate = self?.viewModel?.savedCoordinates?[indexPath.row] else {
                    return
                }
                let globalQueue = DispatchQueue.global(qos: .userInitiated)
                let group = DispatchGroup()
                group.enter()
                globalQueue.sync {
                    self?.viewModel?.deleteCoordinates(coordinate, completion: {
                        print("Deleting: \(String(describing: self?.viewModel?.savedCities![indexPath.row].latitude))")
                        self?.viewModel?.savedCities?.remove(at: indexPath.row)
                    })
                    group.leave()
                }
                group.enter()
                globalQueue.sync {
                    self?.viewModel?.fetchSavedCities(completion: {
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    })
                    group.leave()
                }
            }
            return UISwipeActionsConfiguration(actions: [deleteAction])
        default:
            return nil
        }
    }
    
    override func tableView(
        _ tableView: UITableView,
        leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        switch indexPath.section {
        case 0:
            guard let viewModel = viewModel else {
                return nil
            }
            return setupSaveSwipeActions(with: viewModel.searchResult!)
        case 1:
            guard let viewModel = viewModel else {
                return nil
            }
            return setupSaveSwipeActions(with: (viewModel.currentLocationResult)!)
        case 2:
            return nil
        default:
            return nil
        }
    }
    
    private func getCell(for indexPath: IndexPath) -> SearchTableViewCell? {
        let cell = tableView.cellForRow(at: indexPath)
        if cell?.reuseIdentifier == SearchTableViewCell.searchCellId {
            guard let cell = cell as? SearchTableViewCell else { return nil}
            return cell
        } else {
            return nil
        }
    }
    private func setupSaveSwipeActions(with model: SearchDataModel) -> UISwipeActionsConfiguration {
        let saveActionTitle = NSLocalizedString("Save", comment: "Save action title")
        let saveAction = UIContextualAction(style: .normal, title: saveActionTitle) { [weak self] _, _, _ in
            let lat = model.latitude
            let lon = model.longitude
            let savingGroup = DispatchGroup()
            savingGroup.enter()
            print("1")
            self?.viewModel?.saveCoordinates(
                latitude: lat,
                longitude: lon
            )
            savingGroup.leave()
            print("2")
            self?.viewModel?.fetchSavedCities {
                DispatchQueue.main.async {
                    print("3")
                    self?.tableView.reloadData()
                }
            }
        }
        saveAction.backgroundColor = .systemGreen
        return UISwipeActionsConfiguration(actions: [saveAction])
    }
}
//MARK: Search Bar Delegate
extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] (_) in
            self?.viewModel?.fetchSearchData(searchText: searchText, completion: { [weak self] in
                self?.tableView.reloadData()
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

