//
//  MenuCategoryTableViewCell.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/8/25.
//

import UIKit

/// Menu Category cell for displaying a cake category.
class MenuCategoryTableViewCell: UITableViewCell {

    @IBOutlet weak var innerContainerView: UIView! // created to allows us to make the cell's width smaller than the table views width
    @IBOutlet weak var categoryImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // innerContainerView styling
        innerContainerView.layer.cornerRadius = 10
        innerContainerView.layer.masksToBounds = false
        innerContainerView.layer.shadowColor = UIColor.black.cgColor
        innerContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        innerContainerView.layer.shadowOpacity = 0.2
        innerContainerView.layer.shadowRadius = 4
        
        categoryImageView.layer.cornerRadius = 10 // category image styling
        
        self.selectionStyle = .none // we don't want this cell to change how it looks when we select it
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
