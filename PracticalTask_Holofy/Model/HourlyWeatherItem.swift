//
//  HourlyWeatherItem.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import UIKit

class HourlyWeatherItem: Weather, WeatherPresentable {
    var icon: UIImage {
        return WeatherIconImagePicker.getImage(named: iconName)
    }
    
    var temperatureText: String {
        return "\(temperature: self.temperature)"
    }
    
    var dateText: String {
        return self.date.getHour()
    }
}
