//
//  DifficultyLevelsViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-08-08.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class DifficultyLevelsViewController: UIViewController {
    let db = Firestore.firestore()
    var selectedCategory: String?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkUser()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onScoreBoardButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPersonalScoreScreen", sender: self)
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        logoutUser()
    }

    @IBAction func onAboutButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAboutScreen", sender: self)
        
    }
    @IBAction func onCategoryButtonTapped(_ sender: UIButton) {
        if let selectedCategory = sender.titleLabel?.text{
            print("selectedCategory\(selectedCategory)")
        }
        performSegue(withIdentifier: "goToQuestionScreen", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "goToQuestionScreen" {
                let destination = segue.destination as! QuestionViewController
                destination.category = selectedCategory
//                destination.currentScore = Int(userScore.text ?? "0")
        }
    }

    func checkUser(){
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            if let user = user {
              let uid = user.uid
                getUserData(id: uid)
            }
        } else {
            dismiss(animated: true)
        }
    }
    func logoutUser() {
        do {
            try Auth.auth().signOut()
        }
        catch {
            print("already logged out")
        }
        dismiss(animated: true)
    }
    func getUserData(id: String){
        let docRef = db.collection("users").document(id)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()
                let name = dataDescription?["name"] as? String ?? "Guest"
                let score = dataDescription?["score"] as? Int ?? 0
                print("Document data: \(score)")
                
                self.userName.text = "Hello, \(name)"
                self.userScore.text = String(score)
            } else {
                print("Document does not exist")
            }
        }
       
    }
    
 
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
         }

}
