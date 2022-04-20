//
//  DataProvider.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import Foundation

protocol DataProvidable {
    func searchMovies(searchTerm: String, page: Int, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void)
}

// Building a data provider that we can use across the app to decode data.
struct DataProvider: APIDataProvidable, DataProvidable {
    func searchMovies(searchTerm: String, page: Int, completion: @escaping (Result<TopLevelDictionary, NetworkError>) -> Void) {
        
        guard let baseURL = URL(string: "https://api.themoviedb.org") else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/3/search/movie"
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "3f64f83f672e4cfbb49b63b5374d0b27")
        let searchTermQueryItem = URLQueryItem(name: "query", value: searchTerm)
        let pageQueryItem = URLQueryItem(name: "page", value: page.description)
        urlComponents?.queryItems = [apiKeyQueryItem, searchTermQueryItem, pageQueryItem]
        
        guard let finalURL = urlComponents?.url else { return }
        
        perform(URLRequest(url: finalURL)) { data in
            switch data {
            case .success(let encodedData):
                do {
                    let decodedTLD = try JSONDecoder().decode(TopLevelDictionary.self, from: encodedData)
                    completion(.success(decodedTLD))
                } catch {
                    completion(.failure(.errorDecoding(error)))
                }
            case .failure(let error):
                completion(.failure(.errorDecoding(error)))
            }
        }
    }
}
