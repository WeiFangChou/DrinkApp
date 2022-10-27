//
//  HistoryTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/17.
//

import UIKit

protocol HistoryTableViewCellDelegate: HistoryViewController {
    func reOrderButtonTap(cell: HistoryTableViewCell)
}

class HistoryTableViewCell: UITableViewCell {
    
    static let Identifier = "HistoryTableViewCell"
    var delegate: HistoryTableViewCellDelegate?
    @IBOutlet weak var orderDrinksImage: UIImageView!
    
    @IBOutlet weak var orderDrinksTitleLabel: UILabel!
    
    @IBOutlet weak var orderDrinkssecTitleLabel: UILabel!
    
    @IBOutlet weak var orderDrinkstrdTitleLabel: UILabel!
    
    
    @IBAction func orderReOrderButtonTap(_ sender: AnyObject) {
        delegate?.reOrderButtonTap(cell: self)
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
