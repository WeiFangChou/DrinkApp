//
//  OrderDetailTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/11/13.
//

import UIKit

class OrderDetailTableViewCell: UITableViewCell {
    
    static let Identifier: String = "OrderDetailTableViewCell"
    
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var drinkDetailLabel: UILabel!
    @IBOutlet weak var drinkCostLabel: UILabel!
    @IBOutlet weak var drinkImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
