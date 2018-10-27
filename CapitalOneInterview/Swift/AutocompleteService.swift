//
//  AutocompleteService.swift
//  CapitalOneInterview
//
//  Created by Dan Deng on 9/5/18.
//  Copyright © 2018 Dan Deng. All rights reserved.
//

import Foundation

typealias FetchCompletion = ([SearchResult], NSError?) -> Void

class AutocompleteService {

    func fetchResults(forQuery query: String, completion: FetchCompletion) {
        // Fetches search results on a background queue
    }

}
