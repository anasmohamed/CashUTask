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
               apiService.fetchProducts{ [weak self] (success, products, error) in
                   guard let self = self else {
                       return
                   }

                   guard error == nil else {
                       self.state = .error
                   // self.alertMessage = error?.errorDescription
                       return
                   }

                self.processFetchedPhoto(products: products!)
                   self.state = .populated
               }
           }
           
           func getCellViewModel( at indexPath: IndexPath ) -> ProductListCellViewModel {
               return cellViewModels[indexPath.row]
           }
           
           func createCellViewModel( product: Product ) -> ProductListCellViewModel {

                            
            return ProductListCellViewModel( titleText: product.prductName,
                                              
                                             imageUrl: product.productImage)
           }
           
           private func processFetchedPhoto( products: [Product] ) {
               self.products = products // Cache
               var vms = [ProductListCellViewModel]()
               for product in products {
                   vms.append(createCellViewModel(product: product))
               }
               self.cellViewModels = vms
           }
           
       }

  
