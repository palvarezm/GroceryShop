//
//  GroceryTableViewCell.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {

    @IBOutlet weak var groceryImageView: UIImageView!
    @IBOutlet weak var groceryInfoStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var itemCounter: ItemCounter!
    
    var groceryItemViewModel: GroceryItemViewModel? {
        didSet {
            titleLabel.text = groceryItemViewModel?.title.capitalizingFirstLetter()
            descriptionLabel.text = groceryItemViewModel?.details
            priceLabel.text = groceryItemViewModel?.price
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupView() {
        groceryInfoStackView.spacing = 4
        titleLabel.font = .boldSystemFont(ofSize: 20)
        descriptionLabel.font = descriptionLabel.font.withSize(16)
        descriptionLabel.numberOfLines = 2
        groceryImageView.image = UIImage(named: "fruitbowl")
    }
    
    func configure(itemViewModel: GroceryItemViewModel, onCounterChangeClosure: @escaping OnCounterChangeClosure) {
        self.groceryItemViewModel = itemViewModel
        itemCounter.configure(usingViewModel: itemViewModel.itemCounterViewModel, onCounterChangeClosure: onCounterChangeClosure)
    }
    
    func updateGroceryImage(image: UIImage) -> Void {
        self.groceryImageView.image = image
    }
}
