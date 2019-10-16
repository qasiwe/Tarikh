//
//  result.swift
//  ENT
//
//  Created by Dinmukhammed on 20.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import UIKit

class ResultCell: UITableViewCell {
    
    @IBOutlet weak var curQuestonNumber: UILabel!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var wrongAnswerText: UILabel!
    @IBOutlet weak var rightAnswerText: UILabel!
  
    @IBOutlet weak var contentBlock: UIView!
    @IBOutlet weak var wrongImage: UIImageView!
    @IBOutlet weak var rightImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentBlock.layer.masksToBounds = false
        
        backgroundColor = .clear
        isUserInteractionEnabled = false
        
        contentBlock.layer.cornerRadius = 4
        contentBlock.layer.shadowColor = UIColor.black.cgColor
        contentBlock.layer.shadowOpacity = 0.15
        contentBlock.layer.shadowOffset = CGSize.zero
        contentBlock.layer.shadowRadius = 5    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
