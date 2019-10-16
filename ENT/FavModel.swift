//
//  FavModel.swift
//  ENT
//
//  Created by Dinmukhammed on 31.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import Foundation

class FavModel{
    
    
    
    var id: Int64
    var quest = ""
    var ans = ""
    var isKaz = false
    
    init ( id: Int64, quest: String, ans:String , isKaz: Bool){
        self.id = id
        self.quest = quest
        self.ans = ans
        self.isKaz = isKaz
    }
    
    
}
