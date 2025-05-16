//
//  FavoriteCakeCollectionViewCell.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/1/25.
//

import UIKit

/// cell for showcasing a Cake that is on the menu.
class ShowcaseCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.cornerRadius = 8

        // cell shadow
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
}
