//
//  SearchViewCell.swift
//  Weather
//
//  Created by Mitrio on 04.05.2022.
//

import UIKit

final class SearchTableViewCell: UITableViewCell {
    static let searchCellId = "SearchCell"
    var viewModel: SearchTableViewCellViewModelProtocol?
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func configureCell(with model: SearchDataModel) {
        viewModel = SearchTableViewCellViewModel(searchWeather: model)
        cityLabel.text = viewModel?.cityName
        tempLabel.text = viewModel?.temp
        weatherIcon.image = WeatherIcons.getWeatherIcon(for: viewModel!.weatherId)
    }
}
