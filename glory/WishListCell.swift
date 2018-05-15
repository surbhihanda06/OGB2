//
//  WishListCell.swift
//  Chnen
//
//  Created by Navjot Sharma on 11/22/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class WishListCell: UITableViewCell {
    
    @IBAction func btnRemove(_ sender: AnyObject) {
    }
    @IBOutlet var btnRemove: UIButton!
    @IBOutlet var lblPrice: UILabel!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblBrand: UILabel!
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
