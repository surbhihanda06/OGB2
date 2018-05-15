//
//  PaymentMethodCell.swift
//  Chnen
//
//  Created by navjot_sharma on 12/9/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class PaymentMethodCell: UITableViewCell {

    
    @IBOutlet weak var imgPymentMethod: UIImageView!
    @IBOutlet weak var lblPaymentMethod: UILabel!
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
