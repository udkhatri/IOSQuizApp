//
//  ViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-07-27.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func onStartButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToWelcomeScreen", sender: self)
    }
    
}

