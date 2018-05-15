//
//  OrderListCustomCell.swift
//  Chnen
//
//  Created by Navjot Sharma on 12/5/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class OrderListCustomCell: UITableViewCell
{

    @IBOutlet var lblQty: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblBrandName: UILabel!
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
