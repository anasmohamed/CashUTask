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
    @IBOutlet weak var productNameLbl: UILabel!
    var productListCellViewModel : ProductListCellViewModel? {
          didSet {
              productNameLbl.text = productListCellViewModel?.titleText
              productImageView?.sd_setImage(with: URL( string: productListCellViewModel?.imageUrl ?? "" ), completed: nil)
          }
      }


}
