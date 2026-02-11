//
//  ViewController.swift
//  ProductsApp
//
//  Created by Ted Philip Lat on 2/11/26.
//

import UIKit

class ViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    var models: [Product] = []
    
    // MARK: ViewController Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        
        fetchData(from: "https://dummyjson.com/products") { [weak self] result in
            guard let self else { return }
            switch result {
            case.success(let models):
                self.models = models
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    tableView.reloadData()
                }
            case .failure(let err):
                print(err)
            }
        }
    }
    
    // MARK: Functions
    func fetchData(from urlString: String, completion: @escaping (Result<[Product], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, err in
            if let error = err {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: -1)))
                return
            }
            
            do {
                let models = try JSONDecoder().decode(Products.self, from: data)
                completion(.success(models.products))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProductDetail" {
            if let desitnationVC = segue.destination as? ProductDetailsViewController,
               let productModel = sender as? Product {
                desitnationVC.productData = productModel
            }
        }
    }
}

// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as? ProductTableViewCell
        let product = models[indexPath.row]
        
        cell?.delegate = self
        cell?.bind(productName: product.title, productDescription: product.description)
        return cell ?? UITableViewCell()
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(models[indexPath.row].title)
        performSegue(withIdentifier: "showProductDetail", sender: models[indexPath.row])
    }
}

// MARK: ProductTableViewCellDelegate
extension ViewController: ProductTableViewCellDelegate {
    func didTapAddToCart(_ productName: String) {
        let alertController = UIAlertController(title: "Add to cart success!", message: "Thank you for adding \(productName) to your cart. Happy shopping!", preferredStyle: .alert)
        self.present(alertController, animated: true)
        
        let alertAction = UIAlertAction(title: "Got it", style: .default) { [weak self] _ in
            self?.dismiss(animated: true)
        }
        
        alertController.addAction(alertAction)
    }
}
