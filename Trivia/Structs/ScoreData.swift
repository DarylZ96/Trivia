//
//  ScoreData.swift
//  Trivia
//
//  Created by Daryl Zandvliet on 06/12/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import Foundation


struct ScoreBoardItem: Codable {
    let name: String
    let score: String
    
    var highscore: Int {
        return Int(score)!
    }
    
    //sorteren
    static func > (lhs:ScoreBoardItem, rhs:ScoreBoardItem) -> Bool {
        return lhs.highscore > rhs.highscore
    }
    
}

