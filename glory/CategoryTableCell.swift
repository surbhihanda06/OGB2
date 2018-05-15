//
//  CategoryTableCell.swift
//  Chnen
//
//  Created by navjot_sharma on 11/9/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell {

    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblcategoryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
