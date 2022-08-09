//
//  ViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-07-27.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    var userId: String = "11"
    var isUserLogedIn: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func checkUser(){
        if Auth.auth().currentUser != nil {
            performSegue(withIdentifier: "gotoHomeScreen", sender: self)
        } else {
          isUserLogedIn = false
            performSegue(withIdentifier: "goToWelcomeScreen", sender: self)
        }
    }
    @IBAction func onStartButtonTapped(_ sender: UIButton) {
        checkUser()
       
    }
    func alert(message:String){
        let alert = UIAlertController(title: "title", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

