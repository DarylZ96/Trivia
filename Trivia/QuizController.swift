//
//  QuizController.swift
//  Trivia
//
//  Created by Daryl Zandvliet on 06/12/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import Foundation

class QuizController {
    
    let baseURL = URL(string: "https://opentdb.com/api.php?amount=10&category=21&difficulty=easy&type=multiple")!
    
    // fetch the questions and answers from opentdb
    
    func fetchQuestions(completion: @escaping ([Question]?) -> Void) {
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let data = data,
                let results = try? jsonDecoder.decode(Trivia.self, from: data) {
                completion(results.questions)
                return
            } else {
                completion(nil)
            }
        }
        
        task.resume()
    }
    
    let scoreURL = URL(string: "https://ide50-darylz96.cs50.io:8080/")!
    
    //POST the score of an user to the server
    
    func postScore(score:Int, name:String) {
        
        let highscoreURL = scoreURL.appendingPathComponent("highscores")
        var request = URLRequest(url: highscoreURL)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        //        let fdata: [String: Int] = ["score":finalscore]
        
        let postString = "name=\(name)&score=\(score)"
        request.httpBody = postString.data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else{
                print("error")
                return
            }
        }
        task.resume()
        
    }
    
    //fetch the scores from the highscore list
    
    func fetchScores(completion: @escaping ([ScoreBoardItem]?) -> Void) {
        
        let scoreURL = URL(string: "https://ide50-darylz96.cs50.io:8080/")!
        let highscoreURL = scoreURL.appendingPathComponent("highscores")
        
        let task = URLSession.shared.dataTask(with: highscoreURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            do {
            if let data = data {
                let scores = try jsonDecoder.decode([ScoreBoardItem].self, from: data)
                completion(scores)
            } else {
                print("something went wrong")
                completion(nil)
            }
            } catch {
                    print(error)
                }
                
            
        }
    
        task.resume()
    

}
    
    
    
    
    //testing
    
//    func fetchCategories(completion: @escaping ([String]?) -> Void) {
//        let url = baseURL!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let data = data,
//                let jsonDictionary = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
//                let categories = jsonDictionary?["categories"] as? [String] {
//                completion(categories)
//            } else {
//                completion(nil)
//            }
//        }
//        task.resume()
//    }
//
//

}
