//
//  HomeTableViewCell.swift
//  DrinkApp
//
//  Created by WeiFangChou on 2022/9/25.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemSubTitleLabel: UILabel!
    @IBOutlet weak var itemSub2TitleLabel: UILabel!
    
    @IBOutlet weak var hotImageView: UIImageView!
    @IBOutlet weak var coldImageView: UIImageView!
    @IBOutlet weak var caffeineImageView: UIImageView!
    
    @IBOutlet weak var recommendImageView: UIImageView!
    
    @IBOutlet weak var newImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
        
    }
    
    func setupUI() {
        backgroundView = UIImageView(image: UIImage(named: "grass"))
        layer.cornerRadius = 20
        layer.masksToBounds = true
        backgroundColor = .SkyBlue
        
        
    }
    

}
