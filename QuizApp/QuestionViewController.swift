//
//  QuestionViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-08-08.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class QuestionViewController: UIViewController {
    let db = Firestore.firestore()
    let auth = Auth.auth()
    @IBOutlet weak var answerDLabel: UIButton!
    @IBOutlet weak var answerCLabel: UIButton!
    @IBOutlet weak var answerBLabel: UIButton!
    @IBOutlet weak var answerALabel: UIButton!
    @IBOutlet weak var QuestionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UIButton!
    var category: String?
    var currentScore: Int?
    var correctAnswer: String?
    var answer1: String?
    var answer2: String?
    var answer3: String?
    var answer4: String?
    
    var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.setTitle("Current score: \(score)", for: .normal)
        guard category == nil else{
            print("no category")
            return
        }
        guard currentScore == nil else {
            return
        }
        QuestionLabel.layer.masksToBounds = true
        QuestionLabel.layer.cornerRadius = 16
        print("cat is: \(String(describing: category)) and score is: \(currentScore)")
        showQuiz(category: category ?? "HTML")
    }
    
    @IBAction func onAnswerATapped(_ sender: UIButton) {
        getRightAnswer(selectedAnswer: "answer_a")
        
    }
    @IBAction func onAnswerBTapped(_ sender: UIButton) {
        getRightAnswer(selectedAnswer: "answer_b")
    }
    
    @IBAction func onAnswerCTapped(_ sender: UIButton) {
        getRightAnswer(selectedAnswer: "answer_c")
        
    }
    @IBAction func onAnswerDTapped(_ sender: UIButton) {
        
        getRightAnswer(selectedAnswer: "answer_d")
    }
    func getRightAnswer(selectedAnswer: String){
        if(correctAnswer == selectedAnswer){
            DispatchQueue.main.async { [self] in
                
                let alert = UIAlertController(title: "Yay!", message: " you've got right answer, Click next for next question", preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Next", style: .cancel, handler:{ [self] (UIAlertAction)in
                    score = score + 1
                    scoreLabel.setTitle("Current score: \(score)", for: .normal)
                    storeUserScore()
                    showQuiz(category: self.category ?? "")
                }))
                self.present(alert, animated: true,completion: nil)
            }
            
        }else{
            let alert = UIAlertController(title: "Oops! you've clicked wrong answer.", message: " Want to re-start?", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Yes", style: .cancel, handler:{ (UIAlertAction)in
                self.showQuiz(category: self.category ?? "")
                self.score = 0
                self.scoreLabel.setTitle("Current score: \(self.score)", for: .normal)
            }))
            alert.addAction(UIAlertAction(title: "No", style: .default, handler:{ (UIAlertAction)in
                self.dismiss(animated: true)
            }))
            self.present(alert, animated: true,completion: nil)
        }
    }
    
    @IBAction func onQuitButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    func showQuiz(category: String){
        guard let url = getUrl(category: category) else{
            print("No URL found")
            return
        }
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            print("Network call completion")
            
            guard error == nil else{
                print(error)
                return
            }
            
            guard let data = data else{
                print("No data received")
                return
            }
            //
            if let dataString = String(data: data, encoding:.utf8){
                print("dataString\(dataString)")
                let jsonData = dataString.data(using: .utf8)!
                if let quizResponse = self.parseJSON(data: jsonData){
                    print("quizResponse:\(quizResponse)")
                    let answers = quizResponse.first!.answers
                    print("answers\(answers)")
                    print(quizResponse.first!.question)
                    print(quizResponse.first!.correct_answer)
                    print(quizResponse.first!.category)
                    self.correctAnswer = quizResponse.first!.correct_answer
                    
                    DispatchQueue.main.async { [self] in
                        quizResponse.forEach { item in
                            print("item::::::::\(item.question)")
                            self.QuestionLabel.text = item.question
                            
                            self.answerALabel.setTitle(item.answers.answer_a, for: .normal)
                            self.answerBLabel.setTitle(item.answers.answer_b, for: .normal)
                            self.answerCLabel.setTitle(item.answers.answer_c, for: .normal)
                            self.answerDLabel.setTitle(item.answers.answer_d, for: .normal)
                            
                            self.answer1 = item.answers.answer_a
                            self.answer2 = item.answers.answer_b
                            self.answer3 = item.answers.answer_c
                            self.answer4 = item.answers.answer_d
                        }
                        
                    }
                }
                
            }
        }
        dataTask.resume()
    }
    private func parseJSON(data : Data) -> [QuizResponse]?{
        let decoder = JSONDecoder()
        var question : [QuizResponse]?
        do{
            question = try decoder.decode([QuizResponse].self, from: data)
            print("question:\(question)")
        }catch{
            showQuiz(category: category ?? "")
            print("Error decoding")
        }
        return question
    }
    
    private func getUrl(category:String)-> URL?{
        let baseUrl = "https://quizapi.io/api/v1/questions"
        let apiKey = "ZtEEMHuPPDfvD7s5kQGKMO1uFfSSUbQ3BMO3D4Sm"
        guard let url = "\(baseUrl)?apiKey=\(apiKey)&category=\(category)&limit=1"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else{
            return nil
        }
        
        print(url)
        
        return URL(string: url)
    }
    func storeUserScore(){
        print("Current score: \(currentScore), main score: \(score)")
            let currentUser = auth.currentUser?.uid
            if let userId = currentUser {
                let userRed = db.collection("users").document(userId)
                userRed.updateData([
                    "score": self.score,
                ]){ err in
                    if let err = err {
                        print("Error adding document: \(err)")
                    } else {
                        print("Document added with ID: \(userRed.documentID)")
                    }
                }
        
        
        }
       
       
    }
    struct QuizResponse: Decodable{
        let question : String
        let answers : Answers
        let category: String
        let correct_answer: String
        
    }
    struct Answers: Decodable{
        let answer_a: String
        let answer_b: String
        let answer_c: String
        let answer_d: String
        
    }
    struct CorrectAnswers: Decodable{
        let answer_a: String
        let answer_b: String
        let answer_c: String
        let answer_d: String
    }
    
    
    
}

