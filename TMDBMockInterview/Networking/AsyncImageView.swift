//
//  AsyncImageView.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import UIKit

class AsyncImageView: UIImageView, APIDataProvidable {
    private let baseImageURL = "https://image.tmdb.org/24eDtuux6l0Mgl8sX8fSxa20HEh.jpg"
    
    func setImage(using posterPath: String) {
        guard let baseURL = URL(string: baseImageURL) else { return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path = "/t/p/w500\(posterPath)"
        guard let finalURL = urlComponents?.url else { return }
        
        perform(URLRequest(url: finalURL)) { [weak self] result in
            DispatchQueue.main.async {
                guard let imageData = try? result.get() else { return }
                self?.image = UIImage(data: imageData)
            }
        }
    }
}
