//
//  LocationListDelegate.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//
import Foundation

protocol LocationListViewDelegate: AnyObject {
    func userDidSelectLocation(at index: Int)
    func userAdd(newLocation: Location)
    func userDeleteLocation(at index: Int)
}
