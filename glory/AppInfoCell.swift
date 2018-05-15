//
//  AppInfoCell.swift
//  Chnen
//
//  Created by navjot_sharma on 12/15/16.
//  Copyright © 2016 navjot_sharma. All rights reserved.
//

import UIKit

class AppInfoCell: UITableViewCell
{

    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
