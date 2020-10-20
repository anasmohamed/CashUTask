//
//  ProductsListViewController.swift
//  CashUTask
//
//  Created by Anas on 10/19/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    @IBOutlet weak var productActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var productListTableView: UITableView!
    
    
    lazy var productListViewModel: ProductListViewModel = {
        return ProductListViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
        // init view model
        initVM()
    }
    func initView() {
        self.navigationItem.title = "Popular"
        
        productListTableView.estimatedRowHeight = 150
        productListTableView.rowHeight = UITableView.automaticDimension
    }
    
    func initVM() {
        
        // Naive binding
        productListViewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                //                    if let message = self?.productListViewModel.alertMessage {
                //                        self?.showAlert( message )
                //                    }
            }
        }
        
        productListViewModel.updateLoadingStatus = { [weak self] () in
            guard let self = self else {
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {
                    return
                }
                switch self.productListViewModel.state {
                case .empty, .error:
                    self.productActivityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListTableView.alpha = 0.0
                    })
                case .loading:
                    self.productActivityIndicator.startAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListTableView.alpha = 0.0
                    })
                case .populated:
                    self.productActivityIndicator.stopAnimating()
                    UIView.animate(withDuration: 0.2, animations: {
                        self.productListTableView.alpha = 1.0
                    })
                }
            }
        }
        
        productListViewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                self?.productListTableView.reloadData()
            }
        }
        
        productListViewModel.initFetch()
        
    }
    
    func showAlert( _ message: String ) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension ProductsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "productCellIdentifier", for: indexPath) as? ProductsListTableViewCell else {
            fatalError("Cell not exists in storyboard")
        }
        
        let cellVM = productListViewModel.getCellViewModel( at: indexPath )
        cell.productListCellViewModel = cellVM
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListViewModel.numberOfCells
    }
    
    
    
}


