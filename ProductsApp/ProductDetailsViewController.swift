//
//  ProductDetailsViewController.swift
//  ProductsApp
//
//  Created by Ted Philip Lat on 2/11/26.
//

import UIKit
import Kingfisher

class ProductDetailsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var shippingInformationLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    // MARK: Variables
    var productData: Product?
    
    // MARK: ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.kf.setImage(with: URL(string: productData?.images.first ?? ""))
        priceLabel.text = "Price: \(productData?.price ?? 0)"
        shippingInformationLabel.text = "Shipping information: \(productData?.shippingInformation ?? "")"
        categoryLabel.text = "Category: \(productData?.category.rawValue ?? "")"
    }
}
