//
//  PersonalViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-08-08.
//

import UIKit
import FirebaseFirestore
class PersonalViewController: UIViewController {
    let db = Firestore.firestore()
    @IBOutlet weak var user1: UILabel!
    @IBOutlet weak var user2: UILabel!
    @IBOutlet weak var user3: UILabel!
    @IBOutlet weak var user4: UILabel!
    @IBOutlet weak var user5: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
        // Do any additional setup after loading the view.
    }
    var userlist: [String] = []
    @IBAction func onBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    func getUserData(){
        db.collection("users")
            .order(by: "score", descending: true)
            .limit(to: 5)
            .getDocuments(){ (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        let user = "\(document.data()["score"] ?? "") : \(document.data()["name"] ?? "")"
                        self.userlist.append(user)
                    }
                    self.user1.text = self.userlist[0]
                    self.user2.text = self.userlist[1]
                    self.user3.text = self.userlist[2]
                    self.user4.text = self.userlist[3]
                    self.user5.text = self.userlist[4]
                }
                
            }
       
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
