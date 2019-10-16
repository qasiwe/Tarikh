//
//  BetaCell.swift
//  ENT
//
//  Created by Dinmukhammed on 17.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit

class BetaCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageLabel: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
