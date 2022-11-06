//
//  ShopBagTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/11/1.
//

import UIKit

class ShopBagTableViewCell: UITableViewCell {
    
    static let Identifier: String = "ShopBagTableViewCell"
    @IBOutlet weak var drinkImageView: UIImageView!
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    
    @IBOutlet weak var drinkDetailLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
