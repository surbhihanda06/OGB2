//
//  ShippingMethodCell.swift
//  Chnen
//
//  Created by navjot_sharma on 12/8/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class ShippingMethodCell: UITableViewCell {

    @IBOutlet weak var lblShippingMethod: UILabel!
    @IBOutlet weak var btnRadio: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
