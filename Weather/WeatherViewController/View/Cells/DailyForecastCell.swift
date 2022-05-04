//
//  DailyForecastCell.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

class DailyForecastCell: UITableViewCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dailyMaxTempLabel: UILabel!
    @IBOutlet weak var dailyMinTempLabel: UILabel!
    @IBOutlet weak var dailyImageView: UIImageView!
    @IBOutlet weak var dailyHumidityLabel: UILabel!

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupDailyCell(for indexPath: IndexPath, with viewModel: [DailyWeatherCellViewModelProtocol]) {
        dailyImageView.image = WeatherIcons.getWeatherIcon(for: viewModel[indexPath.row].dailyWeatherId) 
        dailyHumidityLabel.text = viewModel[indexPath.row].dailyHumidity
        dailyMaxTempLabel.text = viewModel[indexPath.row].dailyMaxTemp
        dailyMinTempLabel.text = viewModel[indexPath.row].dailyMinTemp
        dayLabel.text = viewModel[indexPath.row].date
    }
}
