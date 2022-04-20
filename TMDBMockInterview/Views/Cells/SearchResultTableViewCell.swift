//
//  SearchResultTableViewCell.swift
//  TMDBMockInterview
//
//  Created by Arian Mohajer on 3/27/22.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    func updateViews(movieResult: Movie) {
        self.titleLabel.text = movieResult.title
        if let releaseDate = movieResult.releaseDate {
            self.releaseDateLabel.text = formatDate(initialDate: releaseDate)
        }
        if let rating = movieResult.rating {
            self.ratingLabel.text = "\(rating)"
        }
    }
    
    func formatDate(initialDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateObj = dateFormatter.date(from: initialDate)
        
        dateFormatter.dateFormat = "MMMM d, yyyy"
        guard let dateObj = dateObj else {
            return ""
        }

        return dateFormatter.string(from: dateObj)
    }
}

