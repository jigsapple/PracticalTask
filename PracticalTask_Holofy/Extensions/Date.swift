//
//  Date.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import Foundation

extension Date {
    func getDayOfWeek() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self)
    }
    
    func getHour() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "ha"
        return formatter.string(from: self)
    }
}
