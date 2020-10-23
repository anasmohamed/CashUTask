//
//  ProductListTableViewCell.swift
//  CashUTask
//
//  Created by Anas on 10/19/20.
//  Copyright © 2020 Anas. All rights reserved.
//

import UIKit
import SDWebImage
class ProductsListTableViewCell: UITableViewCell {
  
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameEnLbl: UILabel!

    var productListCellViewModel : ProductListCellViewModel? {
          didSet {
            productNameEnLbl.text = productListCellViewModel?.productNameEn
            productImageView.layer.cornerRadius = 8.0
            productImageView.layer.masksToBounds = true
              productImageView?.sd_setImage(with: URL( string: productListCellViewModel?.imageUrl ?? "" ), completed: nil)
          }
      }


}
