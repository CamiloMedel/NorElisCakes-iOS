//
//  CartItemTableViewCell.swift
//  NorElisCakes
//
//  Created by Camilo Medel on 5/6/25.
//

import UIKit

/// Cart cell for displaying a custom cake which the user has created.
class CartTableViewCell: UITableViewCell {

    var onDelete: (() -> Void)? // allows us to set our deletion code, for removing a item from the cart, when creating instances of this cell
    
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var flavorsNumberLabel: UILabel!
    @IBOutlet weak var flavorOneLabel: UILabel!
    @IBOutlet weak var flavorTwoLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var addOnsLabel: UILabel!
    @IBOutlet weak var specialRequestLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    /// when the delete button is pressed, we run our deletion code that we will set when creating a instance of this cell
    @IBAction func onDeletePress(_ sender: UIButton) {
        onDelete?()
    }
}
