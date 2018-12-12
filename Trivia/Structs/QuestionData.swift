//
//  QuestionData.swift
//  Trivia
//
//  Created by Daryl Zandvliet on 06/12/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import Foundation


struct Trivia: Codable {
    var questions: [Question]
    
    enum CodingKeys: String, CodingKey {
        case questions = "results"
    }
}
    

struct Question: Codable {
    let question: String
    let correctanswer: String
    let incorrectanswers: [String]
    
    enum CodingKeys: String, CodingKey {
        case question
        case correctanswer = "correct_answer"
        case incorrectanswers = "incorrect_answers"
    }
}
    
    

