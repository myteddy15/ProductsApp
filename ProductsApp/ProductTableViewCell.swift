//
//  ProductTableViewCell.swift
//  ProductsApp
//
//  Created by Ted Philip Lat on 2/11/26.
//

import UIKit

protocol ProductTableViewCellDelegate: AnyObject {
    func didTapAddToCart(_ productName: String)
}

class ProductTableViewCell: UITableViewCell {
    // MARK: Outlets
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: Properties
    private var productName: String = "" {
        didSet {
            titleLabel.text = productName
        }
    }
    
    private var productDescription: String = "" {
        didSet {
            descriptionLabel.text = productDescription
        }
    }
    
    weak var delegate: ProductTableViewCellDelegate?
    
    // MARK: Outlet functions
    @IBAction func didTapAddToCart(_ sender: Any) {
        delegate?.didTapAddToCart(productName)
    }
    
    // MARK: Initializations
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    // MARK: Functions
    func bind(productName: String, productDescription: String) {
        self.productName = productName
        self.productDescription = productDescription
    }
}
