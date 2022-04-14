//
//  Weather.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation

class Weather {
    let iconName: String
    let temperature: Temperature
    let date: Date
    
    init(iconName: String, temperature: Double, date: Date) {
        self.iconName = iconName
        self.temperature = Temperature(kelvin: temperature)
        self.date = date
    }
}
