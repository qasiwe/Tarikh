//
//  SearchTableViewCell.swift
//  ENT
//
//  Created by Dinmukhammed on 26.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var contentBlock: UIView!
    @IBOutlet weak var questLabel: UILabel!
    @IBOutlet weak var ansLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentBlock.layer.masksToBounds = false
        backgroundColor = .clear
        isUserInteractionEnabled = false
        
        contentBlock.layer.cornerRadius = 4
        contentBlock.layer.shadowColor = UIColor.black.cgColor
        contentBlock.layer.shadowOpacity = 0.15
        contentBlock.layer.shadowOffset = CGSize.zero
        contentBlock.layer.shadowRadius = 5
        
        
        // Configure the view for the selected state
    }

}
