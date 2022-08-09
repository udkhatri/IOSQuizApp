//
//  WelcomeViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-07-27.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class WelcomeViewController: UIViewController {
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onGuestButtonTapped(_ sender: UIButton) {
        Auth.auth().signInAnonymously { authResult, error in
            var isSuccess: Bool = true
            if let error = error {
                isSuccess = false
                self.showAlert(title: "Signup failed!", message: error.localizedDescription)
                print("Err result: ",error )
            }else{
                if isSuccess == true {
                    // Fetch the user's info
                    guard let user = authResult?.user else {return}
                    guard let providerID = authResult?.additionalUserInfo?.providerID else {return}
                    self.createUser(name:"Guest",email:"nil", id: user.uid, signupMode: providerID)
                    self.goToHomeScreen()
                }
               
            }
        }
//        performSegue(withIdentifier: "goToGuestLoginScreen", sender: self)
    }
 
    func createUser(name:String, email:String,id:String, signupMode:String){
        let userRed = db.collection("users").document(id)
        userRed.setData([
            "name": name,
            "email": email,
            "score": 0,
            "id":id,
            "signupMode": signupMode
        ]){ err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(userRed.documentID)")
            }
        }
    }
    func goToHomeScreen(){
        performSegue(withIdentifier: "gotoHomeScreen", sender: self)
    }
    @IBAction func onSignUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUpScreen", sender: self)
    }
    
    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
    
        performSegue(withIdentifier: "goToLoginScreen", sender: self)
    }
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
         }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
