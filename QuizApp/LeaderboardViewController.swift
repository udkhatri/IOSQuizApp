//
//  LeaderboardViewController.swift
//  QuizApp
//
//  Created by Harprit on 2022-08-08.
//

import UIKit

class LeaderboardViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    private var items: [ItemToDo] = []

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leaderCell", for: indexPath)
        let item = items[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = item.title
        content.secondaryText =  item.description
        cell.contentConfiguration = content
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        loadDefaultItems()
        tableView.dataSource = self
    }
    

    @IBAction func onBackButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    private func loadDefaultItems(){
        items.append(ItemToDo(title: "title 1", description: "Description 1"))
        items.append(ItemToDo(title: "title 2", description: "Description 2"))
        items.append(ItemToDo(title: "title 3", description: "Description 3"))
    }

    struct ItemToDo{
        let title: String
        let description: String
    }

}
