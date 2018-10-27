//
//  TypeaheadViewController.swift
//  CapitalOneInterview
//
//  Created by Dan Deng on 9/5/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

import UIKit

class TypeaheadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties

    let searchField = UITextField()

    let tableView = UITableView()

    let autocompleteService = AutocompleteService()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup searchField
        self.view.addSubview(self.searchField)
        self.searchField.addTarget(self, action: #selector(searchTextDidUpdate), for: .editingChanged)

        // Setup tableView
        self.view.addSubview(self.tableView)
        self.tableView.register(SearchResultCell.self, forCellReuseIdentifier: SearchResultCell.reuseIdentifier)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Candidate implements this
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Candidate implements this
        return UITableViewCell()
    }

    // MARK: - Text field handler

    // Called when the text in searchField is updated
    @objc func searchTextDidUpdate(textField: UITextField) {
        // TODO: Candidate implements this
    }

}
