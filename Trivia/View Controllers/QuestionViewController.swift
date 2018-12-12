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
    @IBOutlet weak var progressView: UIProgressView!
    
    
    let quizController = QuizController()
    var questionIndex :Int = 0
    
    var allquestions = [Question]()
    var answers = [String]()
    var randomanswers = [String]()
    
    var answerchosen = [String]()
    var score :Int = 0

    
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
    
    func collectAnswers(){
        answers = allquestions[questionIndex].incorrectanswers
        answers.append(allquestions[questionIndex].correctanswer)
        pickRandomAnswers()
        
        
    }
    
    func pickRandomAnswers() {
        
        var notrandom = answers
        for _ in 1...4 {
            let randomIndex = Int(arc4random_uniform(UInt32(notrandom.count)))
            randomanswers.append(notrandom[randomIndex])
            notrandom.remove(at: randomIndex)
        }
        updateLabels()
    }
    
    func updateLabels() {
        questionLabel.text = allquestions[questionIndex].question.removingHTMLEntities
        firstAnswer.setTitle(randomanswers[0], for: .normal)
        secondAnswer.setTitle(randomanswers[1], for: .normal)
        thirdAnswer.setTitle(randomanswers[2], for: .normal)
        fourthAnswer.setTitle(randomanswers[3], for: .normal)
        
        let totalProgress = Float(questionIndex) / Float(allquestions.count)
        progressView.setProgress(totalProgress, animated: true)
    }
    
    func nextQuestion () {
        questionIndex += 1
        
        if questionIndex < allquestions.count {
            randomanswers.removeAll()
            updateUI(with: allquestions)
            
        }   else{
            performSegue(withIdentifier: "ShowResults", sender: nil)
        }
    
//    func animateButton(button:UIButton) {
//        UIView.animate(withDuration: 0.2) {
//            self.button.transform =
//                CGAffineTransform(scaleX: 3.0, y: 3.0)
//            self.button.transform =
//                CGAffineTransform(scaleX: 1.0, y: 1.0)
//        }
//        }
        
        
        
    }
    
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
    
    func updateScore() {
        
        if answerchosen[questionIndex] == allquestions[questionIndex].correctanswer {
            score += 1
        }
        else {
            
        }
        print(score)
        nextQuestion()
    }
    
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

