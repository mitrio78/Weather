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
    
    func setupDailyCell(for indexPath: IndexPath, with viewModel: [DailyWeatherModel]) {
        dailyImageView.image = viewModel[indexPath.row].weatherIcon
        dailyHumidityLabel.text = viewModel[indexPath.row].dHumidityString
        dailyMaxTempLabel.text = viewModel[indexPath.row].dMaxTempString
        dailyMinTempLabel.text = viewModel[indexPath.row].dMinTempString
        dayLabel.text = viewModel[indexPath.row].dateStrind
    }
}
