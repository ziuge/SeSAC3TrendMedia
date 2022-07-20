//
//  Search2TableViewCell.swift
//  SeSAC3TrendMedia
//
//  Created by CHOI on 2022/07/19.
//

import UIKit

class Search2TableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImgView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieDateLabel: UILabel!
    @IBOutlet weak var movieDescriptionLabel: UILabel!

    func configureCell(data: Movie) {
        
        movieTitleLabel.font = .boldSystemFont(ofSize: 14)
        movieTitleLabel.text = data.title
        movieDateLabel.text = "\(data.releaseDate) | \(data.runtime)분 | \(data.rate)점"
        movieDescriptionLabel.text = data.overview
        movieDescriptionLabel.numberOfLines = 0
    }
}
