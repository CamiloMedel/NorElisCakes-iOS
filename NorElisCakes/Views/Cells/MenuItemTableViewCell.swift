//
//  MenuItemTableViewCell.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/10/25.
//

import UIKit

/// Menu Item cell for displaying a cake on the NorElisCakes menu.
class MenuItemTableViewCell: UITableViewCell {

    @IBOutlet weak var innerContainerView: UIView! // created to allows us to make the cell's width smaller than the table views width
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var itemImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // innerContainerView styling
        innerContainerView.layer.cornerRadius = 10
        innerContainerView.layer.masksToBounds = false
        innerContainerView.layer.shadowColor = UIColor.black.cgColor
        innerContainerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        innerContainerView.layer.shadowOpacity = 0.2
        innerContainerView.layer.shadowRadius = 4
        
        itemImageView.layer.cornerRadius = 10 // item image styling
        
        self.selectionStyle = .none // we don't want this cell to change how it looks when we select it
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
