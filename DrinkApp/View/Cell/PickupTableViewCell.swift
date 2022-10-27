//
//  PickupTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/16.
//

import UIKit

class PickupTableViewCell: UITableViewCell {
    
    static let Identifier = "PickupTableViewCell"
    
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var regionNameLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
