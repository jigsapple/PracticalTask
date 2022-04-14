//
//  WeatherPresentable.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import UIKit

protocol WeatherPresentable {
    var icon: UIImage { get }
    var temperatureText: String { get }
    var dateText: String { get }
}
