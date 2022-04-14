//
//  HourlyCollectionViewCell.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    static let identifier = "HourlyCollectionViewCell"
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setWeatherData(from weatherItem : WeatherPresentable) {
        self.temperatureLabel.text = weatherItem.temperatureText
        self.hourLabel.text = weatherItem.dateText
        self.weatherIconImageView.image = weatherItem.icon
    }
}
