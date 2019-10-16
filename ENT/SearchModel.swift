//
//  SearchModel.swift
//  ENT
//
//  Created by Dinmukhammed on 25.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import Foundation

class SearchModel{
    


    var id: Int64
    var quest = ""
    var ans = ""


    init ( id: Int64, quest: String, ans:String ){
        self.id = id
        self.quest = quest
        self.ans = ans
       
    }


}
