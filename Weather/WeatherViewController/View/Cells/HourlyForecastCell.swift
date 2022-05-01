//
//  HourlyForecastCell.swift
//  Weather
//
//  Created by Mitrio on 17.04.2022.
//

import UIKit

class HourlyForecastCell: UITableViewCell {
    
    var viewModel: WeatherViewModelProtocol?
    var hourlyViewModel: [HourlyWeatherModel]?
    
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
        print("Cell init")
        viewModel = WeatherTableViewViewModel()
        
        check(viewModel: viewModel)
    
    }
    
    private func check(viewModel: WeatherViewModelProtocol?) {
        guard let _ = viewModel else {
            print("No Model")
            return
        }
        print("there is model")
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
        return hourlyViewModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyWeatherCollectionCell.identifier, for: indexPath) as! HourlyWeatherCollectionCell

        guard let hourlyWeather = hourlyViewModel else {return cell}
        cell.hourlyWeatherLabel.text = hourlyWeather[indexPath.item].htempString
        cell.hourLabel.text = hourlyWeather[indexPath.item].hourString
        cell.hourlyImageView.image = hourlyWeather[indexPath.item].weatherIcon
        return cell
    }
    
    func configure(_ viewModel: [HourlyWeatherModel]?) {
        guard let viewModel = viewModel else {
            return
        }
        self.hourlyViewModel = viewModel
        collectionView.reloadData()
    }
}

extension HourlyForecastCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5, height: contentView.frame.height)
    }
}

