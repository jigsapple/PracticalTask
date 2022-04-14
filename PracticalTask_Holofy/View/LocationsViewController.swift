//
//  LocationsViewController.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 13/04/22.
//

import UIKit

class LocationsViewController: UIViewController {

    @IBOutlet weak var locationListTableView: UITableView!
    @IBOutlet weak var addLocationButton: UIButton!
    @IBOutlet weak var temperatureSwitch: UISwitch!
    
    static let identifier = "LocationsViewController"
    private let defaults = UserDefaults.standard
    var locations = [Location]()
    weak var delegate: LocationListViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationListTableView.delegate = self
        self.locationListTableView.dataSource = self
        self.temperatureSwitch.isOn = TemperatureUnit.shared.boolValue
    }
    
    @IBAction func addLocationButtonTouched(_ sender: Any) {
        guard let searchViewController = self.storyboard?.instantiateViewController(withIdentifier: "SearchLocationViewController") as? SearchLocationViewController else { return }
        searchViewController.delegate = self
        self.present(searchViewController, animated: true, completion: nil)
    }
    
    @IBAction func temperatureSwitchValueChanged(_ sender: UISwitch) {
        self.defaults.set(sender.isOn, forKey: DataKeys.temperatureUnit)
        TemperatureUnit.shared.setUnit(with: sender.isOn)
    }

}

extension LocationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.userDidSelectLocation(at: indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
}

extension LocationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locations.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        guard let cellType = LocationListCellType(rowIndex: indexPath.row) else {
            return false
        }
        return cellType.canEditRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LocationListTableViewCell.identifier, for: indexPath)
        guard let cellType = LocationListCellType(rowIndex: indexPath.row) else {
            return cell
        }
        cell.textLabel?.text = cellType.defaultText ?? self.locations[indexPath.row].name
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.locations.remove(at: indexPath.row)
            defaults.set(locations.count - 1, forKey: DataKeys.locationCount)
            if self.locations.count > 1 {
                let savingList = Array(locations[1...locations.count - 1])
                defaults.setLocations(savingList, forKey: DataKeys.locations)
            } else {
                defaults.removeObject(forKey: DataKeys.locations)
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
            self.delegate?.userDeleteLocation(at: indexPath.row)
        }
    }
}

extension LocationsViewController: SearchViewDelegate {
    func userAdd(newLocation: Location) {
        self.locations.append(newLocation)
        let savingList = Array(locations[1...locations.count - 1])
        defaults.setLocations(savingList, forKey: DataKeys.locations)
        defaults.set(savingList.count, forKey: DataKeys.locationCount)
        self.delegate?.userAdd(newLocation: newLocation)
        self.locationListTableView.reloadData()
    }
}
