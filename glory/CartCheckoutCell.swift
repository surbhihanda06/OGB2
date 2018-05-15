//
//  CartCheckoutCell.swift
//  Chnen
//
//  Created by navjot_sharma on 12/8/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class CartCheckoutCell: UITableViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
