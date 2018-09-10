//
//  SolutionTypeaheadViewController.swift
//  CapitalOneInterview
//
//  Created by Dan Deng on 9/5/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

import UIKit

class SolutionTypeaheadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let searchField = UITextField()

    let tableView = UITableView(frame: .zero)

    let autocompleteService = AutocompleteService()

    var searchResults = [SearchResult]()

    // Dictionary for caching results
    var resultsForQuery: [String: [SearchResult]] = [:]

    // Canceable dispatch work item
    var pendingAutocompleteRequest: DispatchWorkItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = self.tableView.dequeueReusableCell(withIdentifier: SearchResultCell.reuseIdentifier) as? SearchResultCell else {
            return UITableViewCell()
        }
        let searchResult = searchResults[indexPath.row]
        searchResultCell.inflate(with: searchResult)
        return searchResultCell
    }

    // Called when the text in searchField is updated
    func searchTextDidUpdate(textField: UITextField) {
        guard let text = textField.text else {
            return
        }
        if let results = self.resultsForQuery[text] {
            self.searchResults = results
            self.tableView.reloadData()
            return
        }
        // Cancel old autocomplete request
        self.pendingAutocompleteRequest?.cancel()
        let autocompleteRequest = DispatchWorkItem { [weak self] in
            guard let strongSelf = self else {
                return
            }
            strongSelf.autocompleteService.fetchResults(forQuery: text) { (searchResults: [SearchResult], error: NSError?) in
                if let error = error {
                    NSLog(error.localizedDescription)
                    return
                }
                if searchResults.isEmpty {
                    NSLog("No search results")
                    return
                }
                strongSelf.searchResults = searchResults
                strongSelf.resultsForQuery[text] = searchResults
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
        self.pendingAutocompleteRequest = autocompleteRequest
        // Fire autocomplete request after delay to avoid sending excessive requests
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            autocompleteRequest.perform()
        }
    }

}
