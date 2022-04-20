//
//  DetailViewController.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModel!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var moviePoster: AsyncImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.backgroundColor = .systemBlue
        navigationController?.navigationBar.tintColor = .white
        
        updateViews()
    }
    
    func updateViews() {
        titleLabel.text = viewModel.movie.title
        if let releaseDate = viewModel.movie.releaseDate {
            releaseDateLabel.text = "Release Date: \(formatDate(initialDate: releaseDate))"
        }
        descriptionTextView.text = viewModel.movie.overview
        if let posterPathURLString = viewModel.movie.posterPath {
            moviePoster.setImage(using: posterPathURLString)
        } else {
            moviePoster.image = UIImage(systemName: "camera")
        }
    }
    
    func formatDate(initialDate: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-m-dd"
        let dateObj = dateFormatter.date(from: initialDate)
        dateFormatter.dateFormat = "m/d/yy"
        guard let dateObj = dateObj else { return "" }
        return dateFormatter.string(from: dateObj)
    }
}

