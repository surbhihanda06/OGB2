//
//  CartViewCell.swift
//  Chnen
//
//  Created by navjot_sharma on 11/25/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class CartViewCell: UITableViewCell
{
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnSaveForLater: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var lblQty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
