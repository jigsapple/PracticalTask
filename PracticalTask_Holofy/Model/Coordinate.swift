//
//  Coordinate.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation
import CoreLocation

class Coordinate: Codable {
    let latitude: String
    let longitude: String
    
    init(location: CLLocation) {
        self.latitude = String(location.coordinate.latitude)
        self.longitude = String(location.coordinate.longitude)
    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.latitude = String(coordinate.latitude)
        self.longitude =  String(coordinate.longitude)
    }
    
    init(lat: String, lon: String) {
        self.latitude = lat
        self.longitude = lon
    }
}

extension Coordinate: CustomStringConvertible {
    var description: String {
        return "lat: \(self.latitude), lon: \(self.longitude)"
    }
}

extension Coordinate: Equatable {
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
