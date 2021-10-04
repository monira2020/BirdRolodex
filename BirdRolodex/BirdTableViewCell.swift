//
//  BirdTableViewCell.swift
//  BirdRolodex
//
//  Created by Monisha Ravi on 10/3/21.
//

import UIKit

class BirdTableViewCell: UITableViewCell {

    @IBOutlet weak var birdName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
