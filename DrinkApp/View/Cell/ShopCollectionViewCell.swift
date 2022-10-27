//
//  ShopCollectionViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/11.
//

import UIKit

class ShopCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var regionLabel: UILabel! {
        didSet{
            
            self.layer.masksToBounds = true
            self.layer.cornerRadius = 10
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
