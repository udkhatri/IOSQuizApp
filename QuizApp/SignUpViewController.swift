//
//  SignUpViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-07-28.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class SignUpViewController: UIViewController {
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var passwordReEnterField: UITextField!
    
    let db = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func onBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func onSignUpButtonTapped(_ sender: UIButton) {
        let email = emailField.text ?? ""
        let password = passwordField.text ?? ""
        let passwordCheck = passwordReEnterField.text ?? ""
        let name = nameField.text ?? ""
        
        if(email == "" || password == "" || passwordCheck == "" || name == "" ){
            showAlert(title:"Empty field!",message: "All the fields are compulsory please fill all the fields.")
        }else{
            if(password.count < 6){
                showAlert(title: "passowrd to short!", message: "password should be atlease 6 characters long")
            }else{
                if(password != passwordCheck){
                    showAlert(title: "password mismatch!", message: "It Looks like you entered wrong password in re-enter password field. please try again")
                }else{
                    signUpUser(email: email, password: password, name: name)
                }
            }
           
        }
    }

    @IBAction func nameValueChange(_ sender: Any) {
    }
    

    func signUpUser (email: String, password: String, name:String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
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
                    self.showAlert(title: "Signup successful", message: "You can now Login to access your account" )
                    self.createUser(name: name , email: user.email ?? "", id: user.uid , signupMode: providerID)
                
                }
               
            }
        }
    }
    
    func goToHomeScreen(){
        performSegue(withIdentifier: "gotoHomeScreen", sender: self)
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
    func showAlert(title:String, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {_ in
            self.goToHomeScreen()}))
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
