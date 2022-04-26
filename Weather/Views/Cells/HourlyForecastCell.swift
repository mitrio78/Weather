//
//  HourlyForecastCell.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit
//import SnapKit

class HourlyForecastCell: UITableViewCell {
    let weather = HourlyWeatherModel.testData
    
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
        return weather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.identifier, for: indexPath) as! HourlyWeatherCollectionCell
        cell.hourlyImageView.image = weather[indexPath.item].weatherIcon
        cell.hourLabel.text = weather[indexPath.item].hourString
        cell.hourlyWeatherLabel.text = "\(weather[indexPath.item].hourString)ºC"
        return cell
    }
}

extension HourlyForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: contentView.frame.height)
    }
}

