//
//  NetworkError.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case unexpectedError
    case requestError(Error)
    case badURL(URL?)
    case couldNotUnwrap
    case errorDecoding(Error)
    
    var localizedDescription: String {
        switch self {
        case .requestError(let error):
            return "Error performing the task: \(error.localizedDescription)"
        case .badURL:
            return "Unable to make the request with the given URL"
        case .couldNotUnwrap:
            return "Error parsing requested data"
        case .errorDecoding:
            return "Error ecountered when decoding the data"
        case .unexpectedError:
            return "Hmm.. Something went wrong"
        }
    }
}
