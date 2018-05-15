//
//  OrderListCustomHeader.swift
//  Chnen
//
//  Created by Navjot Sharma on 12/5/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class OrderListCustomHeader: UITableViewCell
{
    @IBOutlet var lblTotal: UILabel!
    @IBOutlet var lblAddress: UILabel!
    @IBOutlet var lblOrderNo: UILabel!
    @IBOutlet var lblItems: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
