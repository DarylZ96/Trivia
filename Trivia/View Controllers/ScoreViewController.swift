//
//  ScoreViewController.swift
//  Trivia
//
//  Created by Daryl Zandvliet on 06/12/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var ScoreStack: UIStackView!
    @IBOutlet weak var SubmitStack: UIStackView!
    @IBOutlet weak var ScoreboardStack: UIStackView!
    
    @IBOutlet weak var firstPlace: UILabel!
    @IBOutlet weak var secondPlace: UILabel!
    @IBOutlet weak var thirdPlace: UILabel!
    
    @IBOutlet weak var firstScore: UILabel!
    @IBOutlet weak var secondScore: UILabel!
    @IBOutlet weak var thirdScore: UILabel!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    let quizController = QuizController()
    var finalscore: Int!
    var questions = [Question]()
    
    var highscores: [ScoreBoardItem]!
    
    
    // display the right stacks
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreboardStack.isHidden = true
        navigationItem.hidesBackButton = true
        displayScore()
    }
    
    // set the label to present the final score of the user
    func displayScore() {
        scoreLabel.text = "\(finalscore!) / \(questions.count)"
        
    }
    
    // let the user fill in their name
    // call the postScore function after username is filled in
    // call the scoreboard function to display the highscore list
    
    @IBAction func submitTapped(_ sender: Any) {
        
        if nameField.text == "" {
            let alert = UIAlertController(title: "Please fill in your name", message: "And find out if you're the real MVP", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            }
        
        else {
        
        UIView.animate(withDuration: 0.2) {
            self.submitButton.transform =
                CGAffineTransform(scaleX: 3.0, y: 3.0)
            self.submitButton.transform =
                CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
        quizController.postScore(score: finalscore, name: nameField.text!)
        nameField.endEditing(true)
        
        presentScoreboard()
        }

    }
    
    // present the scoreboard and hide the other stacks
    // save all the user scores in a variable
    func presentScoreboard() {
        ScoreStack.isHidden = true
        SubmitStack.isHidden = true
        ScoreboardStack.isHidden = false
        
        quizController.fetchScores { (highscores) in
            if let highscores = highscores {
                self.updateUI(with: highscores)
                
            }
        }
        
    }
    
    func updateUI(with highscores: [ScoreBoardItem]) {
        DispatchQueue.main.async {
            self.highscores = highscores
            self.updateScoreBoard()

        }
        
    }
    
    // check how many scores the server contains
    // present the top 3 scores
    // hide labels when there are not enough scores available
    
    func updateScoreBoard() {
        let sortedHighscores = highscores.sorted(by: >)
        print(highscores.count)
        
        if highscores.count == 1 {
            
            firstPlace.text = " 1. \(sortedHighscores[0].name)"
            firstScore.text = "\(sortedHighscores[0].highscore)"
            
            secondPlace.isHidden = true
            secondScore.isHidden = true
            thirdPlace.isHidden = true
            thirdScore.isHidden = true
        }
        
        else if highscores.count == 2 {
            firstPlace.text = " 1. \(sortedHighscores[0].name)"
            firstScore.text = "\(sortedHighscores[0].highscore)"
            
            secondPlace.text = " 2. \(sortedHighscores[1].name)"
            secondScore.text = "\(sortedHighscores[1].highscore)"
            
            thirdPlace.isHidden = true
            thirdScore.isHidden = true
        }
        
        else {
        firstPlace.text = " 1. \(sortedHighscores[0].name)"
        firstScore.text = "\(sortedHighscores[0].highscore)"
        
        secondPlace.text = " 2. \(sortedHighscores[1].name)"
        secondScore.text = "\(sortedHighscores[1].highscore)"
        
        thirdPlace.text = " 3. \(sortedHighscores[2].name)"
        thirdScore.text = "\(sortedHighscores[2].highscore)"
        }
        
    }
    
}
