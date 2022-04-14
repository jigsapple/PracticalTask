//
//  Location.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation

struct Location: Codable, Equatable {
    let coordinate: Coordinate
    var name: String?
    
    init(coordinate: Coordinate, name: String? = nil) {
        self.coordinate = coordinate
        self.name = name
    }
}
