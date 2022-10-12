//
//  ShopTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/10/9.
//

import UIKit
import MapKit

class ShopTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var shopMapView: MKMapView! {
        didSet{
            shopMapView.isZoomEnabled = false
            shopMapView.isScrollEnabled = false
            shopMapView.isRotateEnabled = false
            shopMapView.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var shopLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
