//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Daryl Zandvliet on 06/12/2018.
//  Copyright © 2018 Daryl Zandvliet. All rights reserved.
//

import UIKit
import HTMLString

class QuestionViewController: UIViewController {
    
    //outlet section
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstAnswer: UIButton!
    @IBOutlet weak var secondAnswer: UIButton!
    @IBOutlet weak var thirdAnswer: UIButton!
    @IBOutlet weak var fourthAnswer: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    let quizController = QuizController()
    var questionIndex :Int = 0
    
    var allquestions = [Question]()
    var answers = [String]()
    var randomanswers = [String]()
    
    var answerchosen = [String]()
    var score :Int = 0

    
    //fetch questions and save the Json data in a variable
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizController.fetchQuestions { (allquestions) in
        if let allquestions = allquestions {
            self.updateUI(with: allquestions)
            
            }
        }
        
    }

    func updateUI(with allquestions: [Question]) {
        DispatchQueue.main.async {
            self.allquestions = allquestions
            // print(allquestions)
            self.collectAnswers()
        
        }
        

    }
    
    // collect the answers and merge the correct & incorrect answers in a variable
    func collectAnswers(){
        answers = allquestions[questionIndex].incorrectanswers
        answers.append(allquestions[questionIndex].correctanswer)
        pickRandomAnswers()
        
        
    }
    
    // pick a random answer
    func pickRandomAnswers() {
        
        var notrandom = answers
        for _ in 1...4 {
            let randomIndex = Int(arc4random_uniform(UInt32(notrandom.count)))
            randomanswers.append(notrandom[randomIndex])
            notrandom.remove(at: randomIndex)
        }
        updateLabels()
    }
    
    // set all the labels, including the score label
    func updateLabels() {
        questionLabel.text = allquestions[questionIndex].question.removingHTMLEntities
        firstAnswer.setTitle(randomanswers[0], for: .normal)
        secondAnswer.setTitle(randomanswers[1], for: .normal)
        thirdAnswer.setTitle(randomanswers[2], for: .normal)
        fourthAnswer.setTitle(randomanswers[3], for: .normal)
        
        scoreLabel.text = "Score: \(score) / \(questionIndex)"
        
    }
    
    // increment the questionindex to go to the next question
    func nextQuestion () {
        questionIndex += 1
        
        if questionIndex < allquestions.count {
            randomanswers.removeAll()
            updateUI(with: allquestions)
            
        }   else{
            performSegue(withIdentifier: "ShowResults", sender: nil)
        }
   
        
    }
    
    // check which answers is chosen and save the users answers
    @IBAction func answerButtonPressed(_ sender: UIButton) {

        switch sender {
        case firstAnswer:
            answerchosen.append(randomanswers[0])
            UIView.animate(withDuration: 0.2) {
                self.firstAnswer.transform =
                    CGAffineTransform(scaleX: 3.0, y: 3.0)
                self.firstAnswer.transform =
                    CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case secondAnswer:
            answerchosen.append(randomanswers[1])
            UIView.animate(withDuration: 0.2) {
                self.secondAnswer.transform =
                    CGAffineTransform(scaleX: 3.0, y: 3.0)
                self.secondAnswer.transform =
                    CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case thirdAnswer:
            answerchosen.append(randomanswers[2])
            UIView.animate(withDuration: 0.2) {
                self.thirdAnswer.transform =
                    CGAffineTransform(scaleX: 3.0, y: 3.0)
                self.thirdAnswer.transform =
                    CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        case fourthAnswer:
            answerchosen.append(randomanswers[3])
            UIView.animate(withDuration: 0.2) {
                self.fourthAnswer.transform =
                    CGAffineTransform(scaleX: 3.0, y: 3.0)
                self.fourthAnswer.transform =
                    CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        default:
            break
        }
        updateScore()
        
        
        
    }
    
    // update the score to provide feedback to the user
    func updateScore() {
        
        if answerchosen[questionIndex] == allquestions[questionIndex].correctanswer {
            UIView.transition(with: scoreLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.scoreLabel.textColor = .green
            }, completion: nil)
            score += 1
        }
        else {
            UIView.transition(with: scoreLabel, duration: 0.3, options: .transitionCrossDissolve, animations: {
                self.scoreLabel.textColor = .red
            }, completion: nil)
            
        }
        print(score)
        nextQuestion()
    }
    
    // pass the score and question data to the next view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResults" {
            let scoreViewController = segue.destination as! ScoreViewController
            scoreViewController.finalscore = score
            scoreViewController.questions = allquestions
            
        }
    }
    
    
    
    
    
    
//    func formatQuestions() {
//
//        quizController.fetchQuestions { (triviaquestions) in
//            if let triviaquestions = triviaquestions {
//                DispatchQueue.main.async {
//
//                    for x in triviaquestions {
//                        self.allquestions.append(x)
//                    }
//
//
//                }
//            }
//        }
//    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

