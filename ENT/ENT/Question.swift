//
//  Question.swift
//  ENT
//
//  Created by Dinmukhammed on 17.07.17.
//  Copyright © 2017 Dinmukhammed. All rights reserved.
//

import Foundation

class Question {
    
    var id: Int64
    var quest = ""
    var ans: [String]
    var sequenceOfNumbers: [Int]
    var choosenAnswer =  -1
    
    
    init ( id: Int64, quest: String, ans:[String], seq: [Int] ){
        self.id = id
        self.quest = quest
        self.ans = ans
        self.sequenceOfNumbers = seq
    }
    
    
    
    
}
