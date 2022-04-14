//
//  CreationError.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation

enum CreationError: Error {
    case toWeatherViewController
    case toSearchViewController
    
    func andReturn() -> Never {
        fatalError("self")
    }
}
