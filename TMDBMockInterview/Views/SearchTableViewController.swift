//
//  SearchTableViewController.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    var viewModel: SearchTableViewModel!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        viewModel = SearchTableViewModel(delegate: self)
        navigationController?.navigationBar.backgroundColor = .systemBlue
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.result.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as? SearchResultTableViewCell else { return UITableViewCell() }
        cell.updateViews(movieResult: viewModel.result[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.result.count-1 {
            guard let searchTerm = searchBar.text else { return }
            viewModel.search(searchTerm: searchTerm)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            if let index = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? DetailViewController {
                    let movie = viewModel.result[index.row]
                    destination.viewModel = DetailViewModel(movie: movie)
                }
            }
        }
    }
}

extension SearchTableViewController: SearchTableViewModelDelegate {
    func searchResultsRetrieved() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension SearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else {
            print("No text entered.")
            return
        }
        viewModel.page = 1
        viewModel.result = []
        viewModel.search(searchTerm: searchTerm)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.hasMoreResults = true
        if searchText == "" {
            viewModel.result = []
            viewModel.page = 1
            tableView.reloadData()
        }
    }
}

