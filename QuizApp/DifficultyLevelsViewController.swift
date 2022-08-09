//
//  DifficultyLevelsViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-08-08.
//

import UIKit

class DifficultyLevelsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onScoreBoardButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToPersonalScoreScreen", sender: self)
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToMainScreen", sender: self)
    }
    @IBAction func onDifficultButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToQuestionScreen", sender: self)
    }
    @IBAction func onNormalButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToQuestionScreen", sender: self)
    }
    @IBAction func onEasyButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "goToQuestionScreen", sender: self)
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
