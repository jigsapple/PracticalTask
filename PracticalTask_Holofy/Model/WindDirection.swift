//
//  WindDirection.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation

enum WindDirection: Int {
    case n = 0, nne, ne
    case ene, e, ese
    case se, sse, s
    case ssw, sw, wsw, w
    case wnw, nw, nnw
    
    init(degree: Double) {
        let convertedValue = Int((degree - 22.5) + 0.5)
        self = WindDirection(rawValue: convertedValue % 16) ?? .n
    }
}
