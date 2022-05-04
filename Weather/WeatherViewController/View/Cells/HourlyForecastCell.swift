//
//  HourlyForecastCell.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

class HourlyForecastCell: UITableViewCell {
    
    var hourlyWeatherViewModel: [HourlyWeatherCellViewModelProtocol]? = []
    
    private let collectionViewLayout = UICollectionViewFlowLayout()
    lazy private var collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension HourlyForecastCell {
    private func setupUI() {
        collectionViewLayout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        let nibCell = UINib(nibName: "HourlyCollectionCell", bundle: nil)
        collectionView.register(nibCell, forCellWithReuseIdentifier: HourlyWeatherCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        addSubview(collectionView)
        collectionView.frame = contentView.bounds
    }
}

extension HourlyForecastCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        hourlyWeatherViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.identifier, for: indexPath) as! HourlyWeatherCollectionCell
        guard let hourlyWeather = hourlyWeatherViewModel else {
            return cell
        }
        cell.hourlyWeatherLabel.text = hourlyWeather[indexPath.item].hTempString
        cell.hourLabel.text = hourlyWeather[indexPath.item].hourString
        cell.hourlyImageView.image = WeatherIcons.getWeatherIcon(for: hourlyWeather[indexPath.item].weatherId)
        return cell
    }
    
    func configure(_ viewModel: [HourlyWeatherCellViewModelProtocol]?) {
        guard let viewModel = viewModel else {
            return
        }
        self.hourlyWeatherViewModel = viewModel
        collectionView.reloadData()
    }
}

extension HourlyForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: contentView.frame.height)
    }
}

