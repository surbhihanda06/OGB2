//
//  SingleViewCell.swift
//  Chnen
//
//  Created by navjot_sharma on 11/17/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class SingleViewCell: UITableViewCell
{
    @IBOutlet weak var btnWishlist: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
