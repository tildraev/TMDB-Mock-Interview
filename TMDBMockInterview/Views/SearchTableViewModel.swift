//
//  SearchTableViewModel.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import Foundation

protocol SearchTableViewModelDelegate: AnyObject {
    func searchResultsRetrieved()
}

class SearchTableViewModel {

    var result: [Movie] = []
    var delegate: SearchTableViewModelDelegate?
    var dataProvider: DataProvidable
    var page: Int = 1
    var hasMoreResults = true
    
    init(delegate: SearchTableViewModelDelegate, dataProvider: DataProvidable = DataProvider()) {
        self.delegate = delegate
        self.dataProvider = dataProvider
    }
    
    func search(searchTerm: String) {
        if hasMoreResults {
            dataProvider.searchMovies(searchTerm: searchTerm, page: page) { [weak self] result in
                switch result {
                case .success(let topLevelDictionary):
                    self?.result.append(contentsOf: topLevelDictionary.results)
                    self?.delegate?.searchResultsRetrieved()
                    self?.page += 1
                    if let totalPages = topLevelDictionary.total_pages,
                       let page = self?.page {
                        if totalPages <= page {
                            self?.hasMoreResults = false
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
