//
//  HourlyWeatherCollectionCell.swift
//  Weather
//
//  Created by Mitrio on 25.04.2022.
//

import UIKit

class HourlyWeatherCollectionCell: UICollectionViewCell {

    @IBOutlet weak var hourlyWeatherLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourlyImageView: UIImageView!
    
    static let identifier: String = "HourlyCollectionCell"

    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}
