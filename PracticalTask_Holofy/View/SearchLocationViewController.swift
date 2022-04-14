//
//  SearchLocationViewController.swift
//  PracticalTask_Holofy
//
//  Created by Jignesh on 14/04/22.
//

import UIKit
import MapKit

class SearchLocationViewController: UIViewController {

    weak var delegate: SearchViewDelegate?
    static let identifier = "SearchLocationViewController"
    private let searchTableCellIdentifier = "searchResultCell"
    private var searchCompleter = MKLocalSearchCompleter()
    private var searchResults = [MKLocalSearchCompletion]()
    
    @IBOutlet weak var searchResultTable: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSearchBar()
        setUpSearchCompleter()
        setUpSearchResultTable()
    }
    
    private func setUpSearchBar() {
        self.searchBar.showsCancelButton = true
        //self.searchBar.becomeFirstResponder()
        self.searchBar.delegate = self
    }

    private func setUpSearchCompleter() {
        self.searchCompleter.delegate = self
        self.searchCompleter.resultTypes = .address
    }

    private func setUpSearchResultTable() {
        self.searchResultTable.dataSource = self
        self.searchResultTable.delegate = self
    }
}

extension SearchLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            searchResults.removeAll()
            searchResultTable.reloadData()
        }
        searchCompleter.queryFragment = searchText
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchLocationViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResults = completer.results
        searchResultTable.reloadData()
    }
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        print(LocationError.localSearchCompleterFail)
    }
}

extension SearchLocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTable.dequeueReusableCell(withIdentifier: searchTableCellIdentifier, for: indexPath)
        let searchResult = searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        return cell
    }

}

extension SearchLocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedResult = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: selectedResult)
        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, error) in
            guard error == nil else {
                print(LocationError.localSearchRequstFail)
                return
            }
            guard let placeMark = response?.mapItems[0].placemark else {
                return
            }
            let coordinate = Coordinate(coordinate: placeMark.coordinate)
            let locationName = "\(placeMark.locality ?? selectedResult.title)"
            self.delegate?.userAdd(newLocation: Location(coordinate: coordinate, name: locationName))
            self.dismiss(animated: true, completion: nil)
        }
    }
}

extension SearchLocationViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.searchBar.resignFirstResponder()
    }
}
