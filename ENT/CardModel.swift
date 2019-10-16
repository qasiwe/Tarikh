//
//  CardModel.swift
//  ENT
//
//  Created by Dimash on 8/1/17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import Foundation

class CardModel{
    
    var id: Int64
    var quest = ""
    var ans = ""
    
    init ( id: Int64, quest: String, ans:String){
        self.id = id
        self.quest = quest
        self.ans = ans
    }
    
    
}
