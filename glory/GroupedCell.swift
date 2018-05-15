//
//  GroupedCell.swift
//  Chnen
//
//  Created by user on 10/05/18.
//  Copyright © 2018 navjot_sharma. All rights reserved.
//

import UIKit
protocol GroupedCellDelegate {
    func calculateGroupedPrice()
}

class GroupedCell: UITableViewCell {
    @IBOutlet weak var quantityField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var delegate: GroupedCellDelegate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(_ groupDetail: [String: Any])  {
        if let name = groupDetail["name"] as? String {
            nameLabel.text = name
        }
        if let image = groupDetail["img"] as? String {
            productImage.sd_setImage(with: URL(string: image))
        }
        if let price = groupDetail["final_price"] as? String {
            priceLabel.text = "$"+price
        }
        if let qty = groupDetail["qty"] as? String {
            quantityField.text = qty
        }
    }
}
extension GroupedCell : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
             delegate.calculateGroupedPrice()
    }
    
}
