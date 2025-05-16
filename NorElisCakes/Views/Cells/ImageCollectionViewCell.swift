//
//  CakeImageCollectionViewCell.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/3/25.
//

import UIKit

/// cell that displays a image
class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 8
        
        // cell shadow
        self.layer.shadowOffset = CGSize(width: 0, height: 10)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.1
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.masksToBounds = false
    }
}
