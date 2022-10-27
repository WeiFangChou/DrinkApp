//
//  DrinkInfoTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/25.
//

import UIKit

class DrinkInfoTableViewCell: UITableViewCell {
    
    static let Identifier = "DrinkInfoTableViewCell"
    
    @IBOutlet weak var drinkInfoSelectImageView: UIImageView!
    @IBOutlet weak var drinkInfoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
