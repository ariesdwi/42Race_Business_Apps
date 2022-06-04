//
//  ListBusinessTableViewCell.swift
//  42Race_Business_Apps
//
//  Created by Admin on 04/06/22.
//

import UIKit

class ListBusinessTableViewCell: UITableViewCell {

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var titleBusinessLabel: UILabel!
    @IBOutlet weak var BusinessimageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        BusinessimageView.layer.cornerRadius = 20
        BusinessimageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
