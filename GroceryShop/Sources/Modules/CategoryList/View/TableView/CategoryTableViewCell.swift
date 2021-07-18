//
//  CategoryTableViewCell.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 13/07/21.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryCard: CategoryCard!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setImage(using image: UIImage) {
        categoryCard.setImage(using: image)
    }
}
