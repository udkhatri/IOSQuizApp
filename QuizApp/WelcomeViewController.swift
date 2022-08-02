//
//  WelcomeViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-07-27.
//

import UIKit

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onGuestButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToGuestLoginScreen", sender: self)
    }
    @IBAction func onSignUpButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToSignUpScreen", sender: self)
    }
    
    @IBAction func onLoginButtonTapped(_ sender: UIButton) {
    
        performSegue(withIdentifier: "goToLoginScreen", sender: self)
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
