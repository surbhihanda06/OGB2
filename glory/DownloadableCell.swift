//
//  DownloadableCell.swift
//  Chnen
//
//  Created by Rakesh on 8/8/17.
//  Copyright © 2017 navjot_sharma. All rights reserved.
//

import UIKit

class DownloadableCell: UITableViewCell {
    @IBOutlet var lblQty: UILabel!
    @IBOutlet var lblSize: UILabel!
    @IBOutlet var lblProductName: UILabel!
    @IBOutlet var imgProduct: UIImageView!
    @IBOutlet var lblRemaining: UILabel!
    @IBOutlet var lblPlace: UILabel!
    @IBOutlet var lblOrderNo: UILabel!
    @IBOutlet var lblProductOrderNo: UILabel!
    @IBOutlet var lblRemainCount: UILabel!
    @IBOutlet var downloadlinkBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
