//
//  ProductsViewModel.swift
//  CashUTask
//
//  Created by Anas on 10/20/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import Foundation
public enum ProductTableState {
    case loading
    case error
    case empty
    case populated
}
class ProductListViewModel {
    let apiService: ProductAPIServiceProtocol
    private var products: [Product] = [Product]()
    private var productDataStore = ProductDataStore()
    private var cellViewModels: [ProductListCellViewModel] = [ProductListCellViewModel]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    // callback for interfaces
    var state: ProductTableState = .empty {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    var isAllowSegue: Bool = false
    
    var selctedProduct: Product?
    
    var reloadTableViewClosure: (()->())?
    var showAlertClosure: (()->())?
    var updateLoadingStatus: (()->())?
    
    init(apiService: ProductAPIServiceProtocol = ProductAPIService()) {
        self.apiService = apiService
    }
    func initFetch() {
        state = .loading
        if Reachability.isConnectedToNetwork(){
            apiService.fetchProducts{ [weak self] (success, products, error) in
                guard let self = self else {
                    return
                }
                
                guard error == nil else {
                    self.state = .error
                    // self.alertMessage = error?.errorDescription
                    return
                }
                
                self.processFetchedProductAndSaveProductLocal(products: products!)
                self.state = .populated
            }
            
            
            
        }else{
            self.fetchProductsFromCoreData()
        }
        
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> ProductListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCellViewModel( product: Product ) -> ProductListCellViewModel {
        return ProductListCellViewModel(productNameEn: product.productNameEn,imageUrl: product.productImage)
    }
    
    private func processFetchedProductAndSaveProductLocal( products: [Product] ) {
        self.products = products
        var vms = [ProductListCellViewModel]()
        for product in products {
            vms.append(createCellViewModel(product: product))
        }
        productDataStore.saveProductIntoCoreData(products: products)
        self.cellViewModels = vms
    }
//
    func saveProductIntoCoreData(products:[Product])  {
        self.productDataStore.saveProductIntoCoreData(products: products)
    }
    func fetchProductsFromCoreData() {
        products =  productDataStore.fetchProductsFromCoreData()
        var vms = [ProductListCellViewModel]()
        for product in products {
            vms.append(createCellViewModel(product: product))
        }
        self.cellViewModels = vms
    }
    
}


