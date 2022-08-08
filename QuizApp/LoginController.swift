//
//  LoginController.swift
//  QuizApp
//
//  Created by Harprit on 2022-07-28.
//

import UIKit
import FirebaseAuth

class LoginController: UIViewController {

    @IBOutlet weak var emailValue: UITextField!
    @IBOutlet weak var passwordValue: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginPressed(_ sender: Any) {
        let email = emailValue.text ?? ""
        let password = passwordValue.text ?? ""
        if(email != "" && password != ""){
            Auth.auth().signIn(withEmail: email, password: password){ (authResult, error) in
                var isSuccess: Bool = true
                if let error = error {
                    isSuccess = false
                    self.showAlert(title: "Signin failed!", message: error.localizedDescription)
                }else{
                    if isSuccess == true {
                        // Fetch the user's info
                        guard let uid = authResult?.user.uid else {return}
                        self.showAlert(title:"Login Succesfull",message: uid)
                        // Safely unwrap the boolean value rather than forcing it with "!" which could crash your app if a nil value is found
                        guard let providerID = authResult?.additionalUserInfo?.providerID else {return}
                       
                        print("Got info: ",providerID, "ID is: ",uid)
                    }
                }
            }
        }else{
            self.showAlert(title:"Empty field!",message: "All the fields are compulsory please fill all the fields.")
        }
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
