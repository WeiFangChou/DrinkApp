//
//  OrderTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/24.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    static let Identifier = "OrderTableViewCell"
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var selectLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
