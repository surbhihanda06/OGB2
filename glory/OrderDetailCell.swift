//
//  OrderDetailCell.swift
//  Chnen
//
//  Created by Navjot Sharma on 12/7/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {
    
    @IBOutlet var lblDelivery: UILabel!
    @IBOutlet var lblQty: UILabel!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var imgProduct: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
