//
//  CategoryCard.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 13/07/21.
//

import UIKit

typealias CategorySelectionHandler = (CategoryItemViewModel) -> (Void)

@IBDesignable
class CategoryCard: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var descriptionLabelsBackgroundView: UIView!
    @IBOutlet weak var descriptionLabelsStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var containerButton: UIButton!
    
    var handler: CategorySelectionHandler?
    var categoryViewModel: CategoryItemViewModel? {
        didSet {
            titleLabel.text = categoryViewModel?.name.uppercased()
            subtitleLabel.text = categoryViewModel?.details
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
        setupView()
    }
    
    private func initView() {
        guard let view = self.loadViewFromNib(nibName: String(describing: CategoryCard.self)) else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 5.0
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        descriptionLabelsBackgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        descriptionLabelsStackView.distribution = .fillEqually
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        subtitleLabel.textColor = .white
        subtitleLabel.numberOfLines = 0
        containerButton.setTitle("", for: .normal)
        contentView.bringSubviewToFront(containerButton)
        backgroundImage.image = UIImage(named: "category-placeholder")
        backgroundImage.backgroundColor = .white
    }
    
    func setImage(using image: UIImage) -> (Void) {
        backgroundImage.image = image
        backgroundImage.contentMode = .scaleAspectFill
    }
    
    func setHandler(categorySelectionHandler: @escaping CategorySelectionHandler) {
        self.handler = categorySelectionHandler
    }
    
    @IBAction func onTapContainer(_ sender: Any) {
        if let safeCategoryViewModel = categoryViewModel {
            handler?(safeCategoryViewModel)
        }
    }
}
