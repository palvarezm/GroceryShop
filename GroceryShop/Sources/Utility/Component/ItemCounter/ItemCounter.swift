//
//  ItemCounter.swift
//  GroceryShop
//
//  Created by Paul Alvarez on 19/07/21.
//

import UIKit

typealias OnCounterChangeClosure = (CartItem) -> (Void)

@IBDesignable
final class ItemCounter: UIView {
    @IBOutlet weak var totalContainerStackView: UIStackView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var itemCounterStackView: UIStackView!
    @IBOutlet weak var substractUnitButton: UIButton!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var addUnitButton: UIButton!
    
    var onCounterChangeClosure: OnCounterChangeClosure?
    
    var itemCounterViewModel = ItemCounterViewModel() {
        didSet {
            addToCartButton.isHidden = itemCounterViewModel.showCounter
            itemCounterStackView.isHidden = !itemCounterViewModel.showCounter
            unitsLabel.text = "\(itemCounterViewModel.counterValue)"
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
        guard let view = self.loadViewFromNib(nibName: String(describing: ItemCounter.self)) else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    func setupView() {
        totalContainerStackView.distribution = .fillEqually
        totalContainerStackView.backgroundColor = .secondary
        addToCartButton.setTitle("add_product_to_cart_button".localized, for: .normal)
        addToCartButton.setTitleColor(.white, for: .normal)
        addUnitButton.setTitle("+", for: .normal)
        addUnitButton.setTitleColor(.white, for: .normal)
        substractUnitButton.setTitle("-", for: .normal)
        substractUnitButton.setTitleColor(.white, for: .normal)
        unitsLabel.backgroundColor = .white
        unitsLabel.textAlignment = .center
        itemCounterStackView.isHidden = true
        itemCounterStackView.distribution = .fillEqually
    }
    
    func configure(usingViewModel itemCounterViewModel: ItemCounterViewModel, onCounterChangeClosure: @escaping OnCounterChangeClosure) -> Void {
        self.itemCounterViewModel = itemCounterViewModel
        self.onCounterChangeClosure = onCounterChangeClosure
    }
    
    @IBAction func onAddToCartTap(_ sender: Any) {
        itemCounterViewModel.addToCart()
        let cartItem = CartItem(skuId: itemCounterViewModel.id, value: itemCounterViewModel.counterValue)
        onCounterChangeClosure?(cartItem)
    }
    
    @IBAction func onSubstractTap(_ sender: Any) {
        itemCounterViewModel.onDecrement()
        let cartItem = CartItem(skuId: itemCounterViewModel.id, value: itemCounterViewModel.counterValue)
        onCounterChangeClosure?(cartItem)
    }
    
    @IBAction func onAddTap(_ sender: Any) {
        itemCounterViewModel.onIncrement()
        let cartItem = CartItem(skuId: itemCounterViewModel.id, value: itemCounterViewModel.counterValue)
        onCounterChangeClosure?(cartItem)
    }
}
