//
//  LocationManagerDelegate.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation

protocol LocationManagerDelegate: AnyObject {
    func locationManagerDidUpdate(currentLocation: Location)
}
